describe 'Actionman', ->

  describe 'TalkFormCtrl', -> 
    scope = null
    ctrl = null
    talk = {
      $save:   jasmine.createSpy('$save'),
      $update: jasmine.createSpy('$update'),
      $delete: jasmine.createSpy('$delete'),
      $get:    jasmine.createSpy('$get')
    }

    describe 'managing an talk', ->
      beforeEach inject ($rootScope, $controller) ->
        TalkResource = jasmine.createSpy('TalkResource').andReturn(talk)
        scope = $rootScope.$new()
        ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: { eventId: '1', talkId: '1' }, TalkResource: TalkResource })

      it 'should set the talk correctly', ->
        expect(scope.talk).toEqual(talk);

      describe 'when creating a talk', ->
        it 'should save the resource', ->
          scope.create()
          expect(talk.$save).toHaveBeenCalled()

      describe 'when updating a talk', ->
        it 'should update the resource', ->
          scope.update()
          expect(talk.$update).toHaveBeenCalled()

      describe 'when deleting a talk', ->
        it 'should delete the resource', ->
          scope.delete()
          expect(talk.$delete).toHaveBeenCalledWith({ eventId: '1', talkId: '1' }, jasmine.any(Function), jasmine.any(Function))

    describe 'existing talk provided', ->
      beforeEach inject ($rootScope, $controller) ->
        TalkResource = jasmine.createSpy('TalkResource').andReturn(talk)
        scope = $rootScope.$new()
        ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: { eventId: '1', talkId: '1' }, TalkResource: TalkResource })

      it 'should get the resource', ->
        scope.create()
        expect(talk.$get).toHaveBeenCalled()

    describe 'successfully interacting with the resource', ->
      beforeEach inject ($rootScope, $controller) ->
        TalkResource = jasmine.createSpy('TalkResource').andReturn(talk)
        scope = $rootScope.$new()
        ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: { eventId: '1', talkId: '1' }, TalkResource: TalkResource })

      it 'should clear any errors', ->
        scope.errors = 'lalalala'
        success = scope.talk.$get.mostRecentCall.args[1]
        success()
        expect(scope.errors).toBeNull();

      describe 'when a response is provided', ->
        it 'should set the talk', ->
          success = scope.talk.$get.mostRecentCall.args[1]
          success({talk: 'a talk'})
          expect(scope.talk).toEqual({talk: 'a talk'})

      describe 'when a response is not provided', ->
        it 'should set the talk to null', ->
          success = scope.talk.$get.mostRecentCall.args[1]
          success()
          expect(scope.talk).toBeNull();

    describe 'error interacting with the resource', ->
      beforeEach inject ($rootScope, $controller) ->
        TalkResource = jasmine.createSpy('TalkResource').andReturn(talk)
        scope = $rootScope.$new()
        ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: { eventId: '1', talkId: '1' }, TalkResource: TalkResource })

      it 'should set the errors', ->
        scope.errors = null
        error = scope.talk.$get.mostRecentCall.args[2]
        error({data: { errors: 'some errors'} })
        expect(scope.errors).toEqual('some errors')
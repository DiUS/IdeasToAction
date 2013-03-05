describe 'Actionman', ->

  describe 'EventFormCtrl', -> 
    scope = null
    ctrl = null
    event = {
      $save:   jasmine.createSpy('$save'),
      $update: jasmine.createSpy('$update'),
      $delete: jasmine.createSpy('$delete'),
      $get:    jasmine.createSpy('$get')
    }

    describe 'managing an event', ->
      beforeEach inject ($rootScope, $controller) ->
        EventResource = jasmine.createSpy('EventResource').andReturn(event)
        scope = $rootScope.$new()
        ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: { eventId: '1' }, EventResource: EventResource })

      it 'should set the event correctly', ->
        expect(scope.event).toEqual(event);

      describe 'when creating an event', ->
        it 'should save the resource', ->
          scope.create()
          expect(event.$save).toHaveBeenCalled()

      describe 'when updating an event', ->
        it 'should update the resource', ->
          scope.update()
          expect(event.$update).toHaveBeenCalled()

      describe 'when deleting an event', ->
        it 'should delete the resource', ->
          scope.delete()
          expect(event.$delete).toHaveBeenCalledWith({ eventId: '1' }, jasmine.any(Function), jasmine.any(Function))

    describe 'existing event provided', ->
      beforeEach inject ($rootScope, $controller) ->
        EventResource = jasmine.createSpy('EventResource').andReturn(event)
        scope = $rootScope.$new()
        ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: { eventId: '1' }, EventResource: EventResource })

      it 'should get the resource', ->
        scope.create()
        expect(event.$get).toHaveBeenCalled()

    describe 'successfully interacting with the resource', ->
      beforeEach inject ($rootScope, $controller) ->
        EventResource = jasmine.createSpy('EventResource').andReturn(event)
        scope = $rootScope.$new()
        ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: { eventId: '1' }, EventResource: EventResource })

      it 'should clear any errors', ->
        scope.errors = 'lalalala'
        success = scope.event.$get.mostRecentCall.args[1]
        success()
        expect(scope.errors).toBeNull();

      describe 'when a response is provided', ->
        it 'should set the event', ->
          success = scope.event.$get.mostRecentCall.args[1]
          success({event: 'an event'})
          expect(scope.event).toEqual({event: 'an event'})

      describe 'when a response is not provided', ->
        it 'should set the event to null', ->
          success = scope.event.$get.mostRecentCall.args[1]
          success()
          expect(scope.event).toBeNull();

    describe 'error interacting with the resource', ->
      beforeEach inject ($rootScope, $controller) ->
        EventResource = jasmine.createSpy('EventResource').andReturn(event)
        scope = $rootScope.$new()
        ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: { eventId: '1' }, EventResource: EventResource })

      it 'should set the errors', ->
        scope.errors = null
        error = scope.event.$get.mostRecentCall.args[2]
        error({data: { errors: 'some errors'} })
        expect(scope.errors).toEqual('some errors')
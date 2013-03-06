describe 'FormResourceService', -> 
  id = 'talk' # any identifier
  scope = null
  service = null
  Resource = null
  resource = 
    $save:   jasmine.createSpy('$save'),
    $update: jasmine.createSpy('$update'),
    $delete: jasmine.createSpy('$delete'),
    $get:    jasmine.createSpy('$get')
  params = {}

  beforeEach(module('Actionman'));

  beforeEach inject ($rootScope) ->
    Resource = jasmine.createSpy('Resource').andReturn(resource)
    scope = $rootScope.$new()

  describe '#bind', ->
    describe 'adds attributes to the $scope', ->
      beforeEach inject (FormResourceService) ->
        FormResourceService.bind id, scope, Resource, params

      it 'should set the resource correctly', ->
        expect(scope[id]).toEqual(resource);

      it 'should not get the resource', ->
        expect(resource.$get).not.toHaveBeenCalled()

      describe 'when creating an resource', ->
        beforeEach -> scope.create()

        it 'should save the resource', ->
          expect(resource.$save).toHaveBeenCalled()

      describe 'when updating an resource', ->
        beforeEach -> scope.update()

        it 'should update the resource', ->
          expect(resource.$update).toHaveBeenCalled()

      describe 'when deleting an resource', ->
        beforeEach -> scope.delete()

        it 'should delete the resource', ->
          expect(resource.$delete).toHaveBeenCalledWith(params, jasmine.any(Function), jasmine.any(Function))

    describe 'existing resource provided', ->
      beforeEach inject (FormResourceService) ->
        params = talkId: 1
        FormResourceService.bind id, scope, Resource, params

      it 'should get the resource', ->
        expect(resource.$get).toHaveBeenCalled()

  describe 'successfully interacting with the resource', ->
    beforeEach inject (FormResourceService) ->
        params = talkId: 1
        FormResourceService.bind id, scope, Resource, params

    it 'should clear any errors', ->
      scope.errors = 'lalalala'
      success = scope[id].$get.mostRecentCall.args[1]
      success()
      expect(scope.errors).toBeNull()

    describe 'when a response is provided', ->
      it 'should set the resource', ->
        success = scope[id].$get.mostRecentCall.args[1]
        success({event: 'an event'})
        expect(scope[id]).toEqual({event: 'an event'})

    describe 'when a response is not provided', ->
      it 'should set the resource to null', ->
        success = scope[id].$get.mostRecentCall.args[1]
        success()
        expect(scope[id]).toBeNull();

  describe 'error interacting with the resource', ->
    beforeEach inject (FormResourceService) ->
        params = talkId: 1
        FormResourceService.bind id, scope, Resource, params

    it 'should set the errors', ->
      scope.errors = null
      error = scope[id].$get.mostRecentCall.args[2]
      error({data: { errors: 'some errors'} })
      expect(scope.errors).toEqual('some errors')
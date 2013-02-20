describe 'Actionman', ()->

  describe 'IdeaCtrl', () -> 
    ideaData = { 
      body: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
    }

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1.json").
            respond(ideaData)

      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaCtrl', { $scope: scope, $routeParams: { ideaId: 1 }, dataCache: $cacheFactory('fake cache') })


    describe "#update", ()->

      it 'should set the ideaId correctly', () ->
        scope.update()
        $httpBackend.flush()
        expect(scope.ideaId).toEqual(1);

      it 'should create "idea" model obtained restfully', () ->
        scope.update()
        expect(scope.idea).toBeUndefined()
        $httpBackend.flush()
        expect(scope.idea).toEqual(ideaData);

      it 'should expose an update method', () ->
        scope.update()
        $httpBackend.flush()
        expect(scope.update).toBeDefined()

      it 'should execute a callback within update if one is given', () ->
        callback = jasmine.createSpy 'callback'
        scope.update(callback)
        $httpBackend.flush()
        expect(callback).toHaveBeenCalled()


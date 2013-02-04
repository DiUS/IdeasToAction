describe 'ActionmanApp', ()->

  describe 'IdeaCtrl', () -> 
    ideaData = { body: 'Body language affects how others see us, but it may also change how we see ourselves.'}

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1.json").
            respond(ideaData)
      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaCtrl', { $scope: scope, $routeParams: { ideaId: 1 } })

    it 'should set the ideaId correctly', () ->
      expect(scope.ideaId).toBeUndefined
      $httpBackend.flush()
      expect(scope.ideaId).toEqual(1);

    it 'should create "idea" model obtained restfully', () ->
      expect(scope.idea).toBeUndefined
      $httpBackend.flush()
      expect(scope.idea).toEqual(ideaData);
    
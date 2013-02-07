describe 'ActionmanApp', ()->

  describe 'IdeaCtrl', () -> 
    ideaData = { body: 'Body language affects how others see us, but it may also change how we see ourselves.'}
    actionsData = [ { description: 'Examine your own body language in different social situations.'} ]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1.json").
            respond(ideaData)

      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1/actions.json").
            respond(actionsData)

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
    
    it 'should create "actions" in "idea" model obtained restfully', () ->
      expect(scope.idea).toBeUndefined
      $httpBackend.flush()
      expect(scope.idea.actions).toEqual(actionsData);
    
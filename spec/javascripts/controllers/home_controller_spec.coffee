describe 'ActionmanApp', ()->

  describe 'HomeCtrl', () -> 
    ideas = [{ body: 'Body language affects how others see us, but it may also change how we see ourselves.'}]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/recent.json").
            respond(ideas)
      scope = $rootScope.$new()
      ctrl = $controller( 'HomeCtrl', { $scope: scope, $routeParams: { } })

    it 'should set the ideas correctly', () ->
      expect(scope.ideas).toBeUndefined
      $httpBackend.flush()
      expect(scope.ideas).toEqual(ideas);
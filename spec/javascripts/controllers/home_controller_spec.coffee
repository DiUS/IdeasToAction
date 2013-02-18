describe 'ActionmanApp', ()->

  describe 'HomeCtrl', () -> 
    idea = { body: 'Body language affects how others see us, but it may also change how we see ourselves.'}
    action = { description: 'Body language affects how others see us, but it may also change how we see ourselves.'}
    counts = { members: 5, ideas: 6, actions_taken: 7 }

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/counts.json").respond(counts)
      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/random.json").respond(idea)
      $httpBackend.expectGET("#{window.ENDPOINT}/actions/random.json").respond(action)
      scope = $rootScope.$new()
      ctrl = $controller( 'HomeCtrl', { $scope: scope, $routeParams: { }, dataCache: $cacheFactory('fake cache') })

    it 'should set the idea correctly', () ->
      expect(scope.idea).toBeUndefined()
      $httpBackend.flush()
      expect(scope.idea).toEqual(idea);

    it 'should set the actions correctly', () ->
      expect(scope.action).toBeUndefined()
      $httpBackend.flush()
      expect(scope.action).toEqual(action);

    it 'should set the counts correctly', () ->
      expect(scope.counts).toBeUndefined()
      $httpBackend.flush()
      expect(scope.counts).toEqual(counts);
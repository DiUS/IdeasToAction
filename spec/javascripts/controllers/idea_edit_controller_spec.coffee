describe 'Actionman', ()->

  describe 'IdeaEditCtrl', () -> 
    talkData = { title: 'Amy Cuddy: Your body language shapes who you are'}

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_

      $httpBackend.expectGET("#{window.ENDPOINT}/talks/1.json").respond(talkData)

      window.ENDPOINT = 'window_endpoint'
      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaEditCtrl', { $scope: scope, $routeParams: { talkId: 1 } })

    it 'should initialise an empty idea correctly', ()->
      expect(scope.idea).toBeDefined

    it 'should set the ideaId correctly', () ->
      expect(scope.idea.talks).toMatch([])
      $httpBackend.flush()
      expect(scope.idea.talks).toMatch([ talkData ])


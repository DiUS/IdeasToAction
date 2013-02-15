describe 'Actionman', ()->

  describe 'IdeaEditCtrl', () -> 
    talkData = { id: 1, title: 'Amy Cuddy: Your body language shapes who you are'}

    ideaData = {
      body: 'Body language affects how others see us, but it may also change how we see ourselves.',
      talks: [ talkData ],
      actions: [ { description: 'Examine your own body language in different social situations.' } ]
    }

    ideaDataWithId = $.extend($.extend(true, {}, ideaData), { id: 1 })

    scope = null
    ctrl = null
    httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      httpBackend = _$httpBackend_

      window.ENDPOINT = "window_endpoint"

      httpBackend.expectGET("#{window.ENDPOINT}/talks/1.json").respond(talkData)

      window.ENDPOINT = 'window_endpoint'
      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaEditCtrl', { $scope: scope, $routeParams: { talkId: 1 } })

    it 'should initialise an empty idea correctly', ()->
      expect(scope.idea).toBeDefined()

    it 'should set the ideaId correctly', () ->
      expect(scope.idea.talks).toMatch([])
      httpBackend.flush()
      expect(scope.idea.talks).toEqual([ talkData ])

    describe '#submitIdea', ()->

      it 'should do a POST to the server', ()->
        httpBackend.expectPOST("#{window.ENDPOINT}/ideas", ideaData).respond(ideaDataWithId)
        scope.submitIdea(ideaData)
describe 'Actionman', ()->

  beforeEach(module('Actionman'))

  describe 'IdeaEditCtrl', () -> 
    talkData = { id: 1, title: 'Amy Cuddy: Your body language shapes who you are'}

    ideaData = {
      description: 'Body language affects how others see us, but it may also change how we see ourselves.',
      talks: [ talkData ],
      idea_actions: [ { description: 'Examine your own body language in different social situations.' } ]
    }

    ideaDataWithId = $.extend($.extend(true, {}, ideaData), { id: 1 })

    scope = null
    ctrl = null
    httpBackend = null
    navigate = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
      httpBackend = _$httpBackend_
      navigate = $navigate

      window.ENDPOINT = "window_endpoint"

      scope = $rootScope.$new()

      $navigate.swipeScope = { name: "mock swipe scope", resetToTop: jasmine.createSpy('resetToTop') }

      ctrl = $controller( 'IdeaEditCtrl', { $scope: scope, $routeParams: { talkId: 1 }, $navigate, dataCache: $cacheFactory('fake cache') })

    it 'should initialise an empty idea correctly', ()->
      expect(scope.idea).toBeDefined()

    describe "#startNewIdea", ()->

      beforeEach ()->
        scope.startNewIdea(talkData)

      it 'should set up and empty idea correctly', () ->
        expect(scope.idea).toBeDefined()

      it 'should link to the specified talk', () ->
        expect(scope.idea.talks).toEqual([ talkData ])

      it 'should set an empty new action description', () ->
        expect(scope.newActionDescription).toEqual('')

      it 'should reset submitted', ->
        expect(scope.submitted).toEqual(false)

    describe '#submitIdea', ->
      beforeEach ->
        scope.submitted = false
        httpBackend.whenPOST("#{window.ENDPOINT}/ideas", ideaData).respond(ideaDataWithId)

      it 'should set submitted to true', ->
        scope.submitIdea(ideaData)
        expect(scope.submitted).toEqual(true)

      it 'should do a POST to the server', ->
        httpBackend.expectPOST("#{window.ENDPOINT}/ideas", ideaData).respond(ideaDataWithId)
        scope.submitIdea(ideaData)

    describe '#cancel', ()->

      it 'should hide itself using the parent\'s showNewIdeaDialog attribute', ()->
        scope.$parent.showNewIdeaDialog = true
        scope.cancel()
        expect(scope.$parent.showNewIdeaDialog).toEqual(false)


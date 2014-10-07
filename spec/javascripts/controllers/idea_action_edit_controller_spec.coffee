describe 'Actionman', () ->

  beforeEach(module('Actionman'))

  describe 'IdeaActionEditCtrl', () ->
    ideaData = { id: 1, description: "The test idea"}
    ideaActionData = { description: 'The test action.', idea_id: ideaData.id }
    ideaActionDataWithId = $.extend($.extend(true, {}, ideaActionData), { id: 1 })
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

      ctrl = $controller( 'IdeaActionEditCtrl', { $scope: scope, $routeParams: { ideaId: 1 }, $navigate, dataCache: $cacheFactory('fake cache') })

    it 'should initialise an empty idea action correctly', () ->
      expect(scope.idea_action).toBeDefined()

    describe "#startNewIdeaAction", () ->

      beforeEach ()->
        scope.startNewIdeaAction(ideaData.id)

      it 'should initialise an empty idea action correctly', () ->
        expect(scope.idea_action).toBeDefined()

      it 'should set the parent idea id correctly', () ->
        expect(scope.idea_action.idea_id).toEqual(ideaData.id)

      it 'should set an empty new action description', () ->
        expect(scope.idea_action.description).toEqual('')

      it 'should set an empty new action target date', () ->
        expect(scope.idea_action.description).toEqual('')

      it 'should reset submitted', ->
        expect(scope.submitted).toEqual(false)

    describe '#submitIdeaAction', ->

      it 'should do a POST to the server', ->
        httpBackend.expectPOST("#{window.ENDPOINT}/idea_actions", ideaActionData).respond(ideaActionDataWithId)
        scope.submitIdeaAction(ideaActionData)

      it 'should set submitted to true', ->
        scope.submitted = false
        httpBackend.expectPOST("#{window.ENDPOINT}/idea_actions", ideaActionData).respond(ideaActionDataWithId)
        scope.submitIdeaAction(ideaActionData)
        expect(scope.submitted).toEqual(true)

    describe '#cancel', ()->

      it 'should hide itself using the parent\'s showNewIdeaActionDialog attribute', ()->
        scope.$parent.showNewIdeaActionDialog = true
        scope.cancel()
        expect(scope.$parent.showNewIdeaActionDialog).toEqual(false)

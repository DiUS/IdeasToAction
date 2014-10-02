describe 'Actionman', ->

  describe 'IdeaActionCtrl', ->
    scope = null
    $httpBackend = null
    ideaAction = { id: 1, target_date: new Date(), completion_date: null }

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      element = $('<div></div>')

      window.ENDPOINT = 'window_endpoint'

      scope = $rootScope.$new()
      $controller 'IdeaActionCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache'), $element: element }

    it 'should create a doneIt function', ->
      expect(scope.doneIt).toBeDefined()

    it 'saves completion date with', ->
      $httpBackend.expectPUT("#{window.ENDPOINT}/idea_actions/#{ideaAction.id}/complete").respond({})

      scope.doneIt(ideaAction)
      $httpBackend.flush()

    it 'should set the completion date', ->
      $httpBackend.expectPUT("#{window.ENDPOINT}/idea_actions/#{ideaAction.id}/complete").respond({})

      scope.doneIt(ideaAction)
      expect(ideaAction.completion_date).not.toBeNull()
      expect(ideaAction.completion_date.toString()).toEqual((new Date()).toString())

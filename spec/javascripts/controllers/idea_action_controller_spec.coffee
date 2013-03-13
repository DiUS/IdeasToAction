describe 'Actionman', ()->

  describe 'IdeaActionCtrl', () ->
    ideaData = { 
      description: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
    }

    scope = null
    ctrl = null
    $httpBackend = null
    ideaActionId = 1
    ideaScope = { 'update': jasmine.createSpy('update') }

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      element = $('<div></div>')

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectPOST("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/doneIt.json").respond({})

      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaActionCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache'), $element: element })

    it 'should create a doneIt function', () ->
      expect(scope.doneIt).toBeDefined()     
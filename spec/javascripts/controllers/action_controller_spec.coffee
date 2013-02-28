describe 'Actionman', ()->

  describe 'ActionCtrl', () -> 
    ideaData = { 
      description: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
    }

    scope = null
    ctrl = null
    $httpBackend = null
    actionId = 1
    ideaScope = { 'update': jasmine.createSpy('update') }

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      element = $('<div></div>')

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectPOST("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").respond({})

      scope = $rootScope.$new()
      ctrl = $controller( 'ActionCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache'), $element: element })

    it 'should create a doneIt function', () ->
      expect(scope.doneIt).toBeDefined()     
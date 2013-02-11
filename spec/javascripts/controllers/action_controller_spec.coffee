describe 'ActionmanApp', ()->

  describe 'ActionCtrl', () -> 
    ideaData = { 
      body: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
    }

    scope = null
    ctrl = null
    $httpBackend = null
    actionId = 1
    ideaScope = { 'update': jasmine.createSpy('update') }

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectPOST("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").respond({})

      scope = $rootScope.$new()
      ctrl = $controller( 'ActionCtrl', { $scope: scope })

    it 'should create a doneIt function', () ->
      expect(scope.doneIt).toBeDefined      
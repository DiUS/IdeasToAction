describe 'Actionman', ->

  describe 'IdeaActionCtrl', ->
    ideaData = { 
      description: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
    }

    interaction = {
      $save: jasmine.createSpy('$save')
    }

    Interaction = {
      new: jasmine.createSpy('new').andReturn(interaction)
    }

    scope = null
    $httpBackend = null
    ideaActionId = 1
    ideaScope = { 'update': jasmine.createSpy('update') }

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      element = $('<div></div>')

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectPOST("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/doneIt.json").respond({})

      scope = $rootScope.$new()
      $controller 'IdeaActionCtrl', { $scope: scope, Interaction: Interaction, dataCache: $cacheFactory('fake cache'), $element: element }

    it 'should create a doneIt function', ->
      expect(scope.doneIt).toBeDefined()     

    it 'should create a new Interation', ->
      scope.doneIt()
      expect(Interaction.new).toHaveBeenCalled()

    it 'should save the interaction', ->
      scope.doneIt()
      expect(interaction.$save).toHaveBeenCalled()
describe 'IdeaActionsCtrl', -> 
  
  IdeaActionResource = null

  beforeEach inject ($rootScope, $controller) ->
    IdeaActionResource = mix: jasmine.createSpy('mix')
    $controller 'IdeaActionsCtrl', { $scope: $rootScope.$new(), IdeaActionResource: IdeaActionResource }

  it 'should find a mix of the resource', ->
    expect(IdeaActionResource.mix).toHaveBeenCalled()
describe 'IdeasCtrl', -> 
  
  IdeaResource = null

  beforeEach inject ($rootScope, $controller) ->
    IdeaResource = mix: jasmine.createSpy('mix')
    $controller 'IdeasCtrl', { $scope: $rootScope.$new(), IdeaResource: IdeaResource }

  it 'should find a mix of the resource', ->
    expect(IdeaResource.mix).toHaveBeenCalled()
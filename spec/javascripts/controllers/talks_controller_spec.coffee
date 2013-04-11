describe 'TalksCtrl', -> 
  
  TalkResource = null

  beforeEach inject ($rootScope, $controller) ->
    TalkResource = mix: jasmine.createSpy('mix')
    $controller 'TalksCtrl', { $scope: $rootScope.$new(), TalkResource: TalkResource }

  it 'should find a mix of the resource', ->
    expect(TalkResource.mix).toHaveBeenCalled()
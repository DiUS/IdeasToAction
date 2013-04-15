describe 'IdeaActionsCtrl', -> 
  IdeaActionResource = {}
  $scope = null
  mixedActions = 'mixedActions'

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    IdeaActionResource.mix = jasmine.createSpy('mix').andReturn(mixedActions)
    $controller 'IdeaActionsCtrl', { $scope: $scope, IdeaActionResource: IdeaActionResource }

  it 'should find a mix of the resource', ->
    expect(IdeaActionResource.mix).toHaveBeenCalled()

  it 'should assign to scope', ->
    expect($scope.actions).toEqual mixedActions

  describe '#more', ->
    moreActions = 'moreActions'

    beforeEach ->
      $scope.actions = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      IdeaActionResource.query = jasmine.createSpy('query').andReturn(moreActions)
      $scope.more()

    it 'should find more of the resource', ->
      expect(IdeaActionResource.query).toHaveBeenCalledWith excluding: [11, 15, 10, 16, 17]

    it 'should assign to scope', ->
      expect($scope.extraActions).toEqual moreActions
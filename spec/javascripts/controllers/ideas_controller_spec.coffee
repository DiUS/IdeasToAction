describe 'IdeasCtrl', -> 
  IdeaResource = {}
  $scope = null
  mixedIdeas = 'mixedIdeas'

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    IdeaResource.mix = jasmine.createSpy('mix').andReturn(mixedIdeas)
    $controller 'IdeasCtrl', { $scope: $scope, IdeaResource: IdeaResource }

  it 'should find a mix of the resource', ->
    expect(IdeaResource.mix).toHaveBeenCalled()

  it 'should assign to scope', ->
    expect($scope.ideas).toEqual mixedIdeas

  describe '#more', ->
    moreIdeas = 'moreIdeas'

    beforeEach ->
      $scope.ideas = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      IdeaResource.query = jasmine.createSpy('query').andReturn(moreIdeas)
      $scope.more()

    it 'should find more of the resource', ->
      expect(IdeaResource.query).toHaveBeenCalledWith excluding: [11, 15, 10, 16, 17]

    it 'should assign to scope', ->
      expect($scope.extraIdeas).toEqual moreIdeas
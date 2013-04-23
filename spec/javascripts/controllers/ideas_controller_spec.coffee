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

  it 'should indicate more results', ->
    expect($scope.stillMoreComing).toEqual(true);

  it 'should initialise extra ideas', ->
    expect($scope.extraIdeas).toEqual([]);

  describe '#more', ->
    beforeEach ->
      $scope.ideas = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      IdeaResource.query = jasmine.createSpy('query')
      $scope.more()

    it 'should start searching', ->
      expect($scope.searching).toEqual(true);

    it 'should find more of the resource', ->
      expect(IdeaResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17] }, jasmine.any(Function)

    describe 'when no more are found', ->
      beforeEach ->
        IdeaResource.query.mostRecentCall.args[1]([])

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should indicate no more results', ->
        expect($scope.stillMoreComing).toEqual(false);

    describe 'when more are found', ->
      moreIdeas = [ { id: 21 }, { id: 22 }, { id: 23 }, { id: 24 }, { id: 25 } ]
      
      beforeEach ->
        IdeaResource.query.mostRecentCall.args[1](moreIdeas)

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should assign to scope', ->
        expect($scope.extraIdeas).toEqual moreIdeas

      describe 'finding even more ideas', ->
        beforeEach ->
          $scope.more()

        it 'should find more of the resource', ->
          expect(IdeaResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17, 21, 22, 23, 24, 25] }, jasmine.any(Function)
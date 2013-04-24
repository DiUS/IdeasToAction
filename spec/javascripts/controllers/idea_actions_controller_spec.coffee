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

  it 'should indicate more results', ->
    expect($scope.stillMoreComing).toEqual(true);

  it 'should initialise extra actions', ->
    expect($scope.extraActions).toEqual([]);

  describe '#more', ->
    beforeEach ->
      $scope.actions = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      IdeaActionResource.query = jasmine.createSpy('query')
      $scope.more()

    it 'should start searching', ->
      expect($scope.searching).toEqual(true);

    it 'should find more of the resource', ->
      expect(IdeaActionResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17] }, jasmine.any(Function)

    describe 'when no more are found', ->
      beforeEach ->
        IdeaActionResource.query.mostRecentCall.args[1]([])

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should indicate no more results', ->
        expect($scope.stillMoreComing).toEqual(false);

    describe 'when more are found', ->
      moreActions = [ { id: 21 }, { id: 22 }, { id: 23 }, { id: 24 }, { id: 25 } ]
      
      beforeEach ->
        IdeaActionResource.query.mostRecentCall.args[1](moreActions)

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should assign to scope', ->
        expect($scope.extraActions).toEqual moreActions

      describe 'finding even more actions', ->
        beforeEach ->
          $scope.more()

        it 'should find more of the resource', ->
          expect(IdeaActionResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17, 21, 22, 23, 24, 25] }, jasmine.any(Function)
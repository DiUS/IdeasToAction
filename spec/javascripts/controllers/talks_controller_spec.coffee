describe 'TalksCtrl', -> 
  TalkResource = {}
  $scope = null
  mixedTalks = 'mixedTalks'

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    TalkResource.mix = jasmine.createSpy('mix').andReturn(mixedTalks)
    $controller 'TalksCtrl', { $scope: $scope, TalkResource: TalkResource }

  it 'should find a mix of the resource', ->
    expect(TalkResource.mix).toHaveBeenCalled()

  it 'should assign to scope', ->
    expect($scope.talks).toEqual mixedTalks

  it 'should indicate more results', ->
    expect($scope.stillMoreComing).toEqual(true);

  it 'should initialise extra talks', ->
    expect($scope.extraTalks).toEqual([]);

  describe '#more', ->
    beforeEach ->
      $scope.talks = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      TalkResource.query = jasmine.createSpy('query')
      $scope.more()

    it 'should start searching', ->
      expect($scope.searching).toEqual(true);

    it 'should find more of the resource', ->
      expect(TalkResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17] }, jasmine.any(Function)

    describe 'when no more are found', ->
      beforeEach ->
        TalkResource.query.mostRecentCall.args[1]([])

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should indicate no more results', ->
        expect($scope.stillMoreComing).toEqual(false);

    describe 'when more are found', ->
      moreTalks = [ { id: 21 }, { id: 22 }, { id: 23 }, { id: 24 }, { id: 25 } ]

      beforeEach ->
        TalkResource.query.mostRecentCall.args[1](moreTalks)

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should assign to scope', ->
        expect($scope.extraTalks).toEqual moreTalks

      describe 'finding even more talks', ->
        beforeEach ->
          $scope.more()

        it 'should find more of the resource', ->
          expect(TalkResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17, 21, 22, 23, 24, 25] }, jasmine.any(Function)

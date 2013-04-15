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

  describe '#more', ->
    moreTalks = 'moreTalks'

    beforeEach ->
      $scope.talks = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      TalkResource.query = jasmine.createSpy('query').andReturn(moreTalks)
      $scope.more()

    it 'should find more of the resource', ->
      expect(TalkResource.query).toHaveBeenCalledWith excluding: [11, 15, 10, 16, 17]

    it 'should assign to scope', ->
      expect($scope.extraTalks).toEqual moreTalks
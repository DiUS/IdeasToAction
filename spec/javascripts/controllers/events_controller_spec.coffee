describe 'EventsCtrl', -> 
  EventResource = {}
  $scope = null
  mixedEvents = 'mixedEvents'

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    EventResource.mix = jasmine.createSpy('mix').andReturn(mixedEvents)
    $controller 'EventsCtrl', { $scope: $scope, EventResource: EventResource }

  it 'should find a mix of the resource', ->
    expect(EventResource.mix).toHaveBeenCalled()

  it 'should assign to scope', ->
    expect($scope.events).toEqual mixedEvents

  describe '#more', ->
    moreEvents = 'moreEvents'

    beforeEach ->
      $scope.events = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      EventResource.query = jasmine.createSpy('query').andReturn(moreEvents)
      $scope.more()

    it 'should find more of the resource', ->
      expect(EventResource.query).toHaveBeenCalledWith excluding: [11, 15, 10, 16, 17]

    it 'should assign to scope', ->
      expect($scope.extraEvents).toEqual moreEvents
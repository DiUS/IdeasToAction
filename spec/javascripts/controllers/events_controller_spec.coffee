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

  it 'should indicate more results', ->
    expect($scope.stillMoreComing).toEqual(true);

  it 'should initialise extra events', ->
    expect($scope.extraEvents).toEqual([]);

  describe '#more', ->
    beforeEach ->
      $scope.events = featured: [ { id: 11 } ], recent: [ { id: 16 }, { id: 17 } ], popular: [ { id: 15 }, { id: 10 } ]
      EventResource.query = jasmine.createSpy('query')
      $scope.more()

    it 'should start searching', ->
      expect($scope.searching).toEqual(true);

    it 'should find more of the resource', ->
      expect(EventResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17] }, jasmine.any(Function)

    describe 'when no more are found', ->
      beforeEach ->
        EventResource.query.mostRecentCall.args[1]([])

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should indicate no more results', ->
        expect($scope.stillMoreComing).toEqual(false);

    describe 'when more are found', ->
      moreEvents = [ { id: 21 }, { id: 22 }, { id: 23 }, { id: 24 }, { id: 25 } ]
      
      beforeEach ->
        EventResource.query.mostRecentCall.args[1](moreEvents)

      it 'should stop searching', ->
        expect($scope.searching).toEqual(false);

      it 'should assign to scope', ->
        expect($scope.extraEvents).toEqual moreEvents

      describe 'finding even more events', ->
        beforeEach ->
          $scope.more()

        it 'should find more of the resource', ->
          expect(EventResource.query).toHaveBeenCalledWith { excluding: [11, 15, 10, 16, 17, 21, 22, 23, 24, 25] }, jasmine.any(Function)

        it 'should do a a second call resource call to determine if there is still more coming', ->
          expect(EventResource.query.callCount).toBe 3
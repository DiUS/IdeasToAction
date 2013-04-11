describe 'EventsCtrl', -> 
  
  EventResource = null

  beforeEach inject ($rootScope, $controller) ->
    EventResource = mix: jasmine.createSpy('mix')
    $controller 'EventsCtrl', { $scope: $rootScope.$new(), EventResource: EventResource }

  it 'should find a mix of the resource', ->
    expect(EventResource.mix).toHaveBeenCalled()
describe 'EventsEditCtrl', -> 
  eventsData = [{ name: 'Tedx'}, { name: 'Another'}]

  scope = null
  ctrl = null
  navigate = null
  $httpBackend = null

  beforeEach module('Actionman')

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
    navigate = $navigate
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET("#{window.ENDPOINT}/events").respond(eventsData)
    $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }
    scope = $rootScope.$new()
    ctrl = $controller( 'EventsEditCtrl', { $scope: scope, $navigate: navigate })

  it 'should set events once successfully fetched', ->
    expect(scope.events).toBeUndefined()
    $httpBackend.flush()
    expect(scope.events).toEqual(eventsData)

  it 'should refresh page height', ->
    $httpBackend.flush()
    expect(navigate.swipeScope.refreshPageHeight).toHaveBeenCalled()
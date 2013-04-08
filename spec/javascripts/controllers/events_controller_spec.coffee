describe 'EventsCtrl', -> 
  
  scope = null
  navigate = null
  timeout = null
  EventResource = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    navigate = 
      go: jasmine.createSpy('go')
      swipeScope: 
        clearAllPagesForward: jasmine.createSpy('clearAllPagesForward')

    timeout = jasmine.createSpy('timeout').andCallFake (fn, time) -> fn()

    EventResource = mix: jasmine.createSpy('mix')

    scope = $rootScope.$new()
    $controller( 'EventsCtrl', { $scope: scope, $routeParams: { }, $navigate: navigate, $timeout: timeout, EventResource: EventResource, dataCache: $cacheFactory('fake cache') })

  it 'should find a mix of the resource', ->
    expect(EventResource.mix).toHaveBeenCalled()

  it 'should navigate when a search occurs', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.go).toHaveBeenCalledWith('/found?query_text=stuff', 'slide')

  it 'should clear all pages forward', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.swipeScope.clearAllPagesForward).toHaveBeenCalled()
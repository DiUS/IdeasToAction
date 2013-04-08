describe 'IdeasCtrl', -> 
  
  scope = null
  navigate = null
  timeout = null
  IdeaResource = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    navigate = 
      go: jasmine.createSpy('go')
      swipeScope: 
        clearAllPagesForward: jasmine.createSpy('clearAllPagesForward')

    timeout = jasmine.createSpy('timeout').andCallFake (fn, time) -> fn()

    IdeaResource = mix: jasmine.createSpy('mix')

    scope = $rootScope.$new()
    $controller( 'IdeasCtrl', { $scope: scope, $routeParams: { }, $navigate: navigate, $timeout: timeout, IdeaResource: IdeaResource, dataCache: $cacheFactory('fake cache') })

  it 'should find a mix of the resource', ->
    expect(IdeaResource.mix).toHaveBeenCalled()

  it 'should navigate when a search occurs', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.go).toHaveBeenCalledWith('/found?query_text=stuff', 'slide')

  it 'should clear all pages forward', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.swipeScope.clearAllPagesForward).toHaveBeenCalled()
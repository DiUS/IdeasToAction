describe 'TalksCtrl', -> 
  
  scope = null
  navigate = null
  timeout = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    navigate = 
      go: jasmine.createSpy('go')
      swipeScope: 
        clearAllPagesForward: jasmine.createSpy('clearAllPagesForward')

    timeout = jasmine.createSpy('timeout').andCallFake (fn, time) -> fn()

    TalkResource = mix: jasmine.createSpy('mix')

    scope = $rootScope.$new()
    $controller( 'TalksCtrl', { $scope: scope, $routeParams: { }, $navigate: navigate, $timeout: timeout, TalkResource: TalkResource, dataCache: $cacheFactory('fake cache') })

  it 'should navigate when a search occurs', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.go).toHaveBeenCalledWith('/found?query_text=stuff', 'slide')

  it 'should clear all pages forward', ->
    scope.query = text: 'stuff'
    scope.doSearch()
    expect(navigate.swipeScope.clearAllPagesForward).toHaveBeenCalled()
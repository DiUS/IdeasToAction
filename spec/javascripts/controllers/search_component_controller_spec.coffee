describe 'SearchComponentCtrl', -> 
  
  $scope = null
  navigate = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    navigate = 
      go: jasmine.createSpy('go')
      swipeScope: 
        clearAllPagesForward: jasmine.createSpy('clearAllPagesForward')

    timeout = jasmine.createSpy('timeout').andCallFake (fn, time) -> fn()

    $scope = $rootScope.$new()
    $scope.scroller = scrollToPage: jasmine.createSpy('scrollToPage')

    $controller 'SearchComponentCtrl', { $scope: $scope, $navigate: navigate, $timeout: timeout }

  beforeEach ->
    $scope.query = text: 'stuff'
    $scope.doSearch()

  it 'should navigate when a search occurs', ->
    expect(navigate.go).toHaveBeenCalledWith('/found?query_text=stuff', 'slide')

  it 'should clear all pages forward', ->
    expect(navigate.swipeScope.clearAllPagesForward).toHaveBeenCalled()

  it 'should scroll to the top of the page', ->
    expect($scope.scroller.scrollToPage).toHaveBeenCalled()
    
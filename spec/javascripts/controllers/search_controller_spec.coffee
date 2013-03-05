describe 'Actionman', ()->

  beforeEach(module('Actionman'))

  describe 'SearchCtrl', () -> 
    scope = null
    ctrl = null
    httpBackend = null
    navigate = null
    searchResults = [{}, {}, {}]

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
      httpBackend = _$httpBackend_
      navigate = $navigate

      window.ENDPOINT = "window_endpoint"

      scope = $rootScope.$new()

      $navigate.swipeScope = { name: "mock swipe scope", resetToTop: jasmine.createSpy('resetToTop') }

      ctrl = $controller( 'SearchCtrl', { $scope: scope, $routeParams: { query_text: 'body language' } })

    it 'should initialise the query from route params', ()->
      expect(scope.query).toBeDefined()
      expect(scope.query.text).toBeDefined()
      expect(scope.query.text).toEqual('body language')

    describe "#doSearch", ()->

      it "should perform an http call with the specified query", ()->
        httpBackend.expectGET("#{window.ENDPOINT}/search?text=body%20language").respond(searchResults)
        scope.doSearch()


describe 'SearchCtrl', -> 
  scope = null
  $httpBackend = null
  searchResults = [{}, {}, {}]

  beforeEach module('Actionman')

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
    $httpBackend = _$httpBackend_

    window.ENDPOINT = "window_endpoint"

    scope = $rootScope.$new()

    $httpBackend.expectGET("#{window.ENDPOINT}/search?text=body%20language").respond()

    $controller 'SearchCtrl', { $scope: scope, $routeParams: { query_text: 'body language' } }

  it 'should initialise the query from route params', ->
    expect(scope.query).toBeDefined()
    expect(scope.query.text).toBeDefined()
    expect(scope.query.text).toEqual('body language')

  describe "#doSearch", ->
    beforeEach -> scope.results = null

    it "should set the results when successfully responding", ->
      $httpBackend.whenGET("#{window.ENDPOINT}/search?text=body%20language").respond(200, searchResults)
      scope.doSearch()
      $httpBackend.flush()
      expect(scope.results).toEqual(searchResults)

    it 'should set the results to empty on an error response', ->
      $httpBackend.whenGET("#{window.ENDPOINT}/search?text=body%20language").respond(500)
      scope.doSearch()
      $httpBackend.flush()
      expect(scope.results).toEqual([])
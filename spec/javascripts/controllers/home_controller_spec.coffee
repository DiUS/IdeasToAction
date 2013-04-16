describe 'HomeCtrl', -> 
  counts = 'counts'

  $scope = null
  $httpBackend = null

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET("#{window.ENDPOINT}/counts.json").respond(counts)

    $scope = $rootScope.$new()
    $controller 'HomeCtrl', { $scope: $scope, dataCache: $cacheFactory('fake cache') }

  it 'should set the counts correctly', ->
    expect($scope.counts).toBeUndefined()
    $httpBackend.flush()
    expect($scope.counts).toEqual(counts)
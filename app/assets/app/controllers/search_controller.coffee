window.SearchCtrl = ($scope, $http, $routeParams) ->
  $scope.query = { text: $routeParams.query_text }

  $scope.$watch 'query.text', (newValue, oldValue)->
    $routeParams.query_text = newValue
    $scope.doSearch()

  $scope.doSearch = ()->
    $http(method: 'GET', url: "#{window.ENDPOINT}/search", params: $scope.query, cache: false).success( $scope.resultsReceived )

  $scope.resultsReceived = (results) -> 
    $scope.results = results

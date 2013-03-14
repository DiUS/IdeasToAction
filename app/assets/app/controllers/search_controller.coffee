window.SearchCtrl = ($scope, $http, $routeParams) ->
  $scope.query = { text: $routeParams.query_text }

  resultsReceived = (results) -> 
    $scope.results = results

  errorReceived = (error) -> 
    $scope.results = []

  $scope.doSearch = ->
    $http.get("#{window.ENDPOINT}/search", params: $scope.query, cache: false ).success(resultsReceived).error(errorReceived)
window.SearchCtrl = ($scope, $http, $routeParams) ->
  $scope.query = { text: $routeParams.query_text }

  resultsReceived = (results) -> $scope.results = results
  errorReceived   = (error) ->   $scope.results = []

  $scope.doSearch = ->
    $scope.results = null
    $http.get("#{window.ENDPOINT}/search", params: $scope.query, cache: false ).success(resultsReceived).error(errorReceived)
    false

  $scope.doSearch() if $scope.query.text?
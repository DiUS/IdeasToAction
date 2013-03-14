window.SearchCtrl = ($scope, $http, $routeParams) ->
  $scope.query = { text: $routeParams.query_text }

  resultsReceived = (results) -> $scope.results = results

  $scope.doSearch = ->
    $http(method: 'GET', url: "#{window.ENDPOINT}/search", params: $scope.query, cache: false).success(resultsReceived)

  

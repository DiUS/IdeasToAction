window.HomeCtrl = ($scope, $http, $routeParams, dataCache) ->
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data

  $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: dataCache }).success (data) -> 
    $scope.idea = data

  $http.get("#{window.ENDPOINT}/actions/random.json", { cache: dataCache }).success (data) -> 
    $scope.action = data
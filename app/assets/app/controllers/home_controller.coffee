window.HomeCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/counts.json").success (data) -> 
    $scope.counts = data

  $http.get("#{window.ENDPOINT}/ideas/random.json").success (data) -> 
    $scope.idea = data

  $http.get("#{window.ENDPOINT}/actions/random.json").success (data) -> 
    $scope.action = data
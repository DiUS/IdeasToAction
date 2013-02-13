window.HomeCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/counts.json").success (data) -> 
    $scope.counts = data

  $http.get("#{window.ENDPOINT}/ideas/recent.json").success (data) -> 
    $scope.ideas = data

  $http.get("#{window.ENDPOINT}/actions/recent.json").success (data) -> 
    $scope.actions = data
window.HomeCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/ideas/recent.json").success( (data) -> 
    $scope.ideas = data
  )
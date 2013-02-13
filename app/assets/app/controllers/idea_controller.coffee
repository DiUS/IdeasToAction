window.IdeaCtrl = ($scope, $http, $routeParams) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json").success (data) -> 
      $scope.idea = data
      callback() if callback?

  $scope.update()
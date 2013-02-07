window.IdeaCtrl = ($scope, $http, $routeParams) ->
  $scope.ideaId = $routeParams.ideaId
  $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json").success( (data) -> 
    $scope.idea = data

    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}/actions.json").success( (data) -> 
      $scope.idea.actions = data
    )

  )


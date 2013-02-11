window.IdeaCtrl = ($scope, $http, $routeParams) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = () ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json").success (data) -> 
      $scope.idea = data

  $scope.update()
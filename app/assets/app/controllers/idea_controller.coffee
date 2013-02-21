window.IdeaCtrl = ($scope, $http, $routeParams, dataCache) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json", { cache: dataCache }).success (data) -> 
      $scope.idea = data
      $('.loading').removeClass('loading')
      callback() if callback?

  $scope.update()
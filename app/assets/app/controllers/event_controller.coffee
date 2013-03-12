window.EventCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.eventId = $routeParams.eventId
  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}.json", { cache: dataCache }).success (data) -> 
    $scope.event = data
    $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/ideas.json", { cache: dataCache }).success (data) -> 
      $scope.ideas = data
      $navigate.swipeScope.refreshPageHeight()
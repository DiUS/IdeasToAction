
window.TalksCtrl = ($scope, $http, $routeParams, dataCache) ->
  $scope.eventId = $routeParams.eventId
  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks.json", { cache: dataCache }).success( (data) -> 
    $scope.talks = data
  )

 

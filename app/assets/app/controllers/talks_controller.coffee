
window.TalksCtrl = ($scope, $http, $routeParams) ->
  $scope.eventId = $routeParams.eventId
  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks.json").success( (data) -> 
    $scope.talks = data
  )

 

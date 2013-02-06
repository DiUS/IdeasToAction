window.EventCtrl = ($scope, $http, $routeParams) ->
  $scope.eventId = $routeParams.eventId
  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}.json").success( (data) -> 
    $scope.event = data
  )
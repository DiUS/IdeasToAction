window.TalksEventsCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/events.json").success (data) -> 
    $scope.events = data

  $http.get("#{window.ENDPOINT}/talks.json").success (data) -> 
    $scope.talks = data
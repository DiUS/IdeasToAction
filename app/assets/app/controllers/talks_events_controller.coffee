window.TalksEventsCtrl = ($scope, $http, $routeParams, dataCache) ->
  $http.get("#{window.ENDPOINT}/events.json", { cache: dataCache }).success (data) -> 
    $scope.events = data

  $http.get("#{window.ENDPOINT}/talks.json", { cache: dataCache }).success (data) -> 
    $scope.talks = data
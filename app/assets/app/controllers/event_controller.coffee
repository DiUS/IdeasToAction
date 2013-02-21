window.EventCtrl = ($scope, $http, $routeParams, dataCache) ->
  $scope.eventId = $routeParams.eventId

  $scope.header = 'Event <a class="home-page pull-right" href="#/home"><i class="icon-home" /></a>'

  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}.json", { cache: dataCache }).success (data) -> 
    $scope.event = data
    $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/ideas.json", { cache: dataCache }).success (data) -> 
      $scope.ideas = data
      $('.loading').removeClass('loading')
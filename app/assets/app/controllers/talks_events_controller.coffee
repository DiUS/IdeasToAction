window.TalksEventsCtrl = ($scope, $http, $routeParams, dataCache) ->

  $scope.header = 'Talks & events <a class="home-page pull-right" href="#/home"><i class="icon-home" /></a>'

  $http.get("#{window.ENDPOINT}/events.json", { cache: dataCache }).success (data) -> 
    $scope.events = data
    $http.get("#{window.ENDPOINT}/talks.json", { cache: dataCache }).success (data) -> 
      $scope.talks = data
      $('.loading').removeClass('loading')
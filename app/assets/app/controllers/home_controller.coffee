window.HomeCtrl = ($scope, $http, $routeParams, dataCache) ->
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data
    fadeInWhenReady()

  $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: dataCache }).success (data) -> 
    $scope.idea = data
    fadeInWhenReady()

  $http.get("#{window.ENDPOINT}/actions/random.json", { cache: dataCache }).success (data) -> 
    $scope.action = data
    fadeInWhenReady()

  fadeInWhenReady = () ->
    $('body').addClass('fadeIn') if window.ajaxCounter == 0
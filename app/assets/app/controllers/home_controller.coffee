window.HomeCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/counts.json").success (data) -> 
    $scope.counts = data
    fadeInWhenReady()

  $http.get("#{window.ENDPOINT}/ideas/random.json").success (data) -> 
    $scope.idea = data
    fadeInWhenReady()

  $http.get("#{window.ENDPOINT}/actions/random.json").success (data) -> 
    $scope.action = data
    fadeInWhenReady()

  fadeInWhenReady = () ->
    $('body').addClass('fadeIn') if window.ajaxCounter == 0
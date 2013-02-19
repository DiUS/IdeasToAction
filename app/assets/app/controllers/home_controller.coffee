window.HomeCtrl = ($scope, $http, $routeParams, dataCache) ->
  $('#loading').show()

  $scope.refresh = () ->
    $http.get("#{window.ENDPOINT}/counts.json", { cache: false }).success (data) -> 
      $scope.counts = data
      check()

    $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: false }).success (data) -> 
      $scope.idea = data
      check()

    $http.get("#{window.ENDPOINT}/actions/random.json", { cache: false }).success (data) -> 
      $scope.action = data
      check()

  $scope.refresh()

  check = () ->
    $('#loading').fadeOut(500) if window.ajaxCounter == 0
window.HomeCtrl = ($scope, $http, $routeParams, dataCache) ->
  $('#loading').show()

  $scope.header = 'Ideas into action <div class="reload pull-right" onclick="location.reload(true);"><i class="icon-refresh" /></div>'
  
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data
    check()

  $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: dataCache }).success (data) -> 
    $scope.idea = data
    check()

  $http.get("#{window.ENDPOINT}/actions/random.json", { cache: dataCache }).success (data) -> 
    $scope.action = data
    check()

  check = () ->
    $('#loading').fadeOut(500) if window.ajaxCounter == 0
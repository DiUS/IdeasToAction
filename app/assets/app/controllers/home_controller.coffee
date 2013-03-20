window.HomeCtrl = ($scope, $http, $routeParams, $navigate, $timeout, FeaturedResource, dataCache) ->
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data

  $scope.featured = FeaturedResource.query()

  $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: dataCache }).success (data) -> 
    $scope.idea = data

  $http.get("#{window.ENDPOINT}/idea_actions/random.json", { cache: dataCache }).success (data) ->
    $scope.action = data

  $scope.doSearch = -> 
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 600
    false

window.HomeCtrl = ($scope, $http, $routeParams, FeaturedResource, dataCache) ->
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data

  $scope.featured = FeaturedResource.query()

  $http.get("#{window.ENDPOINT}/ideas/random.json", { cache: dataCache }).success (data) -> 
    $scope.idea = data

  $http.get("#{window.ENDPOINT}/actions/random.json", { cache: dataCache }).success (data) -> 
    $scope.action = data
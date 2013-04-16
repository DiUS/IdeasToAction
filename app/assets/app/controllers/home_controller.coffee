window.HomeCtrl = ($scope, $http, dataCache) ->
  $http.get("#{window.ENDPOINT}/counts.json", { cache: dataCache }).success (data) -> 
    $scope.counts = data

window.TalksCtrl = ($scope, $http) ->
  $http.get("#{window.ENDPOINT}/talks.json").success( (data) -> 
    $scope.talks = data
  )

 

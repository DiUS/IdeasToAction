
window.TalksCtrl = ($scope, $http) ->
  $http.get('/talks.json').success( (data) -> 
    $scope.talks = data
  )

 

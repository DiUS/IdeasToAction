
window.TalkCtrl = ($scope, $http) ->
  $http.get('talks/1.json').success( (data) -> 
    $scope.talk = data
  )
 

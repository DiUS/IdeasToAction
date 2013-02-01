
window.TalkCtrl = ($scope, $http, $routeParams) ->
  $scope.talkId = $routeParams.talkId
  $http.get("/talks/#{$scope.talkId}.json").success( (data) -> 
    $scope.talk = data
  )
 

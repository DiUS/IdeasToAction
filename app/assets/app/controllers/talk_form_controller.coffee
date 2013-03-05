window.TalkFormCtrl = ($scope, $routeParams, TalkResource) ->
  $scope.talk = new TalkResource()

  success = (talk) -> 
    $scope.errors = null
    $scope.talk = talk || null

  error = (response) -> 
    $scope.errors = response.data.errors

  # get if id is provided
  $scope.talk.$get { eventId: $routeParams.eventId, talkId: $routeParams.talkId }, success, error if $routeParams.talkId?

  $scope.create = -> 
    $scope.talk.$save success, error

  $scope.update = -> 
    $scope.talk.$update { eventId: $routeParams.eventId, talkId: $routeParams.talkId }, success, error

  $scope.delete = -> 
    $scope.talk.$delete { eventId: $routeParams.eventId, talkId: $routeParams.talkId }, success, error
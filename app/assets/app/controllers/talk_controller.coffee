window.TalkCtrl = ($scope, $http, $routeParams) ->
  $scope.talkId = $routeParams.talkId
  $scope.eventId = $routeParams.eventId

  $scope.showNewIdeaDialog = false

  $scope.createNewIdea = (talk)-> 
    $("#new-idea-dialog").scope().startNewIdea(talk)
    $scope.showNewIdeaDialog = true

  $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}.json").success( (data) -> 
    $scope.talk = data

    $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}/ideas.json").success( (data) -> 
      $scope.talk.ideas = data
    )
  )
 

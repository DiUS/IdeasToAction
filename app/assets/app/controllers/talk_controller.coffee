window.TalkCtrl = ($scope, $http, $routeParams, dataCache) ->
  $scope.talkId = $routeParams.talkId
  $scope.eventId = $routeParams.eventId

  $scope.showNewIdeaDialog = false

  $scope.createNewIdea = (talk)-> 
    $("#new-idea-dialog").scope().startNewIdea(talk)
    $scope.showNewIdeaDialog = true
    $('swipe-view').scope().resetToTop()

  $scope.update = ()->
    $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}.json", { cache: dataCache }).success( (data) -> 
      $scope.talk = data

      $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}/ideas.json", { cache: dataCache }).success( (data) -> 
        $scope.talk.ideas = data
      )
    )
   
  $scope.update()
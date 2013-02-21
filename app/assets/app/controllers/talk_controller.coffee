window.TalkCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.talkId = $routeParams.talkId
  $scope.eventId = $routeParams.eventId

  $scope.showNewIdeaDialog = false

  $scope.header = 'Talk <a class="home-page pull-right" href="#/home"><i class="icon-home" /></a>'

  $scope.createNewIdea = (talk)-> 
    $("#new-idea-dialog").scope().startNewIdea(talk)
    $scope.showNewIdeaDialog = true
    $navigate.swipeScope.resetToTop()

  $scope.update = ()->
    $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}.json", { cache: dataCache }).success( (data) -> 
      $scope.talk = data

      $http.get("#{window.ENDPOINT}/events/#{$scope.eventId}/talks/#{$scope.talkId}/ideas.json", { cache: dataCache }).success( (data) -> 
        $scope.talk.ideas = data
        $('.loading').removeClass('loading')
      )
    )
   
  $scope.update()
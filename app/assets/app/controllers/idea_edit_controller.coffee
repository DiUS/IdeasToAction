window.IdeaEditCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->

  $scope.startNewIdea = (talk) ->
    $scope.idea = { description: '', talks: [ ], idea_actions: [ ] }
    $scope.idea.talks.push(talk) if talk
    $scope.newActionDescription = ''
    $scope

  $scope.cancel = ->
    $navigate.swipeScope.resetToTop()
    $scope.$parent.showNewIdeaDialog = false

  $scope.addNewAction = ->
    return unless @newActionDescription.length > 0
    @idea.idea_actions.push({ description: @newActionDescription })
    @newActionDescription = ''

  $scope.removeAction = (action)->
    @idea.idea_actions.splice(action, 1)

  $scope.validIdea = ->
    (@idea.idea_actions.length > 0) and (@idea.description)

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json", { cache: dataCache }).success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.submitIdea = (idea) ->
    $http.post("#{window.ENDPOINT}/ideas", idea).success (ideaWithId) -> 
      dataCache.removeAll()
      $("#talk").scope().update().success (data)->
        $('body').scope().navigate.go("/ideas/#{ideaWithId.id}")
        $navigate.swipeScope.resetToTop()
        $scope.$parent.showNewIdeaDialog = false

  $scope.startNewIdea($scope.$parent.talk)

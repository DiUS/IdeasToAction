window.IdeaEditCtrl = ($scope, $http, $routeParams) ->

  $scope.startNewIdea = (talk)->
    $scope.idea = { body: '', talks: [ ], actions: [ ] }
    $scope.idea.talks.push(talk) if talk
    $scope.newActionDescription = ''
    $scope

  $scope.cancel = ()->
    $scope.$parent.showNewIdeaDialog = false

  $scope.addNewAction = ()->
    return unless @newActionDescription.length > 0
    @idea.actions.push({ description: @newActionDescription })
    @newActionDescription = ''

  $scope.removeAction = (action)->
    @idea.actions.splice(action, 1)

  $scope.validIdea = ()->
    (@idea.actions.length > 0) and (@idea.body)

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json").success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.submitIdea = (idea) ->
    $http.post("#{window.ENDPOINT}/ideas", idea).success (ideaWithId) -> 
      $('body').scope().navigate.go("/ideas/#{ideaWithId.id}")

  $scope.startNewIdea($scope.$parent.talk)

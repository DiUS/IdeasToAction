window.IdeaEditCtrl = ($scope, $http, $routeParams) ->
  $scope.idea = {
    body: '',
    talks: [],
    actions: [
    ]
  }

  $scope.newActionDescription = ''

  $scope.cancel = ()->
    $('body').scope().navigate.back()

  $scope.addNewAction = ()->
    return if $scope.newAction.$invalid
    @idea.actions.push({ description: @newActionDescription })
    @newActionDescription = ''

  $scope.removeAction = (action)->
    @idea.actions.splice(action, 1)

  $scope.validIdea = ()->
    (@idea.actions.length > 0) and (@idea.body)

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json").success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.retrieveTalkById($routeParams.talkId) if ($routeParams.talkId)

window.IdeaEditCtrl = ($scope, $http, $routeParams) ->
  $scope.idea = {
    body: ''
    talks: [],
    actions: [
      {
        description: 'Love it!'
      }
    ]
  }

  $scope.cancel = ()->
    $('body').scope().navigate.back()

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json").success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.retrieveTalkById($routeParams.talkId) if ($routeParams.talkId)

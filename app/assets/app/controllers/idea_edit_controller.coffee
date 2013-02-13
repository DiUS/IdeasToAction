window.IdeaEditCtrl = ($scope, $http, $routeParams) ->
  $scope.idea = { talks: [] }

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json").success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.retrieveTalkById($routeParams.talkId) if ($routeParams.talkId)

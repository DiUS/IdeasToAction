window.ReactionCtrl = ($scope, $http, dataCache) ->
  $scope.react = (ideaActionId) ->
    $scope.inProgress = true

    $http.post("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/react.json", { text: $scope.reactionText }).success (data) ->
      $("#reaction-#{ideaActionId}").slideToggle 300, () ->
        dataCache.removeAll()
        $("#idea").scope().update()
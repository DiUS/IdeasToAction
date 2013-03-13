window.ReactionCtrl = ($scope, $http, dataCache) ->
  $scope.react = (ideaId, ideaActionId) ->
    $scope.inProgress = true

    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", { text: $scope.reactionText }).success (data) ->
      $("#reaction-#{ideaActionId}").slideToggle 300, () ->
        dataCache.removeAll()
        $("#idea").scope().update()
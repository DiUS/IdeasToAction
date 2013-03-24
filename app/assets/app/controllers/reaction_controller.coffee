window.ReactionCtrl = ($scope, $http, Interaction, dataCache) ->
  $scope.react = ->
    $scope.inProgress = true

    interaction = Interaction.resource()
    interaction.reaction_text = $scope.reactionText
    interaction.$update ->
      $("#reaction-#{interaction.id}").slideToggle 300, ->
        dataCache.removeAll()
        $("#idea").scope().update()
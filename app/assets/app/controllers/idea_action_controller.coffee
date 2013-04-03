window.IdeaActionCtrl = ($scope, $http, $element, $routeParams, Interaction, dataCache) ->
  $scope.doneIt = (ideaActionId) ->
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')

    interaction = Interaction.new()
    interaction.idea_action_id = ideaActionId
    interaction.$save ->
      dataCache.removeAll()
      $(".idea-#{$scope.item.idea_id}").scope().update ->
        setTimeout ->
          $("#reaction-#{interaction.id}").slideToggle 300
        , 300
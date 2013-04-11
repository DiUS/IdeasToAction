window.IdeaActionsCtrl = ($scope, IdeaActionResource) ->
  $scope.actions = IdeaActionResource.mix()

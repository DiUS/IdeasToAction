window.IdeaActionsCtrl = ($scope, IdeaActionResource) ->
  $scope.actions = IdeaActionResource.mix()

  $scope.more = ->
    $scope.extraActions = IdeaActionResource.query excluding: current()    

  current = ->
    featured = $scope.actions.featured.map (action) -> action.id
    popular  = $scope.actions.popular.map  (action) -> action.id
    recent   = $scope.actions.recent.map   (action) -> action.id

    featured.concat popular.concat recent
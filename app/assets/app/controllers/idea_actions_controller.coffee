window.IdeaActionsCtrl = ($scope, IdeaActionResource) ->
  $scope.extraActions = []
  $scope.stillMoreComing = true

  $scope.actions = IdeaActionResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.searching = true
    IdeaActionResource.query { excluding: current() }, (response) ->
      $scope.searching = false
      if response.length == 0
        $scope.stillMoreComing = false 
      else
        $scope.extraActions = $scope.extraActions.concat(response)

  current = ->
    featured = $scope.actions.featured.map (action) -> action.id
    popular  = $scope.actions.popular.map  (action) -> action.id
    recent   = $scope.actions.recent.map   (action) -> action.id

    extraActions = $scope.extraActions.map (action) -> action.id

    featured.concat popular.concat recent.concat extraActions
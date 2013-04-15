window.IdeasCtrl = ($scope, IdeaResource) ->
  $scope.ideas = IdeaResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.extraIdeas = IdeaResource.query excluding: current()

  current = ->
    featured = $scope.ideas.featured.map (idea) -> idea.id
    popular  = $scope.ideas.popular.map  (idea) -> idea.id
    recent   = $scope.ideas.recent.map   (idea) -> idea.id

    featured.concat popular.concat recent
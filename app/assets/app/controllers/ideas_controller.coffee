window.IdeasCtrl = ($scope, IdeaResource) ->
  $scope.extraIdeas = []
  $scope.stillMoreComing = true

  $scope.ideas = IdeaResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.searching = true
    IdeaResource.query { excluding: current() }, (response) ->
      $scope.searching = false
      if response.length == 0
        $scope.stillMoreComing = false 
      else
        $scope.extraIdeas = $scope.extraIdeas.concat(response)

  current = ->
    featured = $scope.ideas.featured.map (idea) -> idea.id
    popular  = $scope.ideas.popular.map  (idea) -> idea.id
    recent   = $scope.ideas.recent.map   (idea) -> idea.id

    extraIdeas = $scope.extraIdeas.map (idea) -> idea.id

    featured.concat popular.concat recent.concat extraIdeas
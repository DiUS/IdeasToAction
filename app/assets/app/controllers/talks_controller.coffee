window.TalksCtrl = ($scope, TalkResource) ->
  $scope.talks = TalkResource.mix()

  $scope.more = ->
    $scope.extraTalks = TalkResource.query excluding: current()    

  current = ->
    featured = $scope.talks.featured.map (talk) -> talk.id
    popular  = $scope.talks.popular.map  (talk) -> talk.id
    recent   = $scope.talks.recent.map   (talk) -> talk.id

    featured.concat popular.concat recent
window.TalksCtrl = ($scope, TalkResource) ->
  $scope.extraTalks = []
  $scope.stillMoreComing = true

  $scope.talks = TalkResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.searching = true
    TalkResource.query { excluding: current() }, (response) ->
      $scope.searching = false
      if response.length == 0
        $scope.stillMoreComing = false 
      else
        $scope.extraTalks = $scope.extraTalks.concat(response)

  current = ->
    featured = $scope.talks.featured.map (talk) -> talk.id
    popular  = $scope.talks.popular.map  (talk) -> talk.id
    recent   = $scope.talks.recent.map   (talk) -> talk.id

    extraTalks = $scope.extraTalks.map (talk) -> talk.id

    featured.concat popular.concat recent.concat extraTalks
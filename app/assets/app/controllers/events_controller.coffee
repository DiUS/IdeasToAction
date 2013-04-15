window.EventsCtrl = ($scope, EventResource) ->
  $scope.events = EventResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.extraEvents = EventResource.query excluding: current()

  current = ->
    featured = $scope.events.featured.map (event) -> event.id
    popular  = $scope.events.popular.map  (event) -> event.id
    recent   = $scope.events.recent.map   (event) -> event.id

    featured.concat popular.concat recent
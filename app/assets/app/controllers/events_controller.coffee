window.EventsCtrl = ($scope, EventResource) ->
  $scope.events = EventResource.mix()

  $scope.more = ->
    $scope.extraEvents = EventResource.query excluding: eventIdsFromScope()    

  eventIdsFromScope = ->
    featured = $scope.events.featured.map (event) -> event.id
    popular  = $scope.events.popular.map  (event) -> event.id
    recent   = $scope.events.recent.map   (event) -> event.id

    featured.concat popular.concat recent
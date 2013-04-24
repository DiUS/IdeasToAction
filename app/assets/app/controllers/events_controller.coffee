window.EventsCtrl = ($scope, EventResource) ->
  $scope.extraEvents = []
  $scope.stillMoreComing = true

  $scope.events = EventResource.mix ->
    $('.loading').removeClass('loading')

  $scope.more = ->
    $scope.searching = true
    EventResource.query { excluding: current() }, (response) ->
      $scope.searching = false
      if response.length == 0
        $scope.stillMoreComing = false 
      else
        $scope.extraEvents = $scope.extraEvents.concat(response)

  current = ->
    featured = $scope.events.featured.map (event) -> event.id
    popular  = $scope.events.popular.map  (event) -> event.id
    recent   = $scope.events.recent.map   (event) -> event.id

    extraEvents = $scope.extraEvents.map (event) -> event.id

    featured.concat popular.concat recent.concat extraEvents
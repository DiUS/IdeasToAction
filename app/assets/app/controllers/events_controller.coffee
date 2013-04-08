window.EventsCtrl = ($scope, EventResource) ->
  $scope.events = EventResource.mix()
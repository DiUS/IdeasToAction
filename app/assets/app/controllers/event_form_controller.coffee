window.EventFormCtrl = ($scope, $routeParams, FormResourceService, EventResource) ->
  FormResourceService.bind 'event', $scope, EventResource, { eventId: $routeParams.eventId }
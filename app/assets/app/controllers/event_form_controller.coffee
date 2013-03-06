window.EventFormCtrl = ($scope, $routeParams, $navigate, FormResourceService, EventResource) ->
  FormResourceService.bind
    id:              'event'
    scope:           $scope
    resource:        EventResource
    params:          { eventId: $routeParams.eventId }
    onDeleteSuccess: -> $navigate.go('/events/edit', 'slide')
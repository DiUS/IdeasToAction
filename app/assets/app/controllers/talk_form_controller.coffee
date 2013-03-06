window.TalkFormCtrl = ($scope, $routeParams, $navigate, FormResourceService, TalkResource) ->
  FormResourceService.bind
    id:              'talk'
    scope:           $scope
    resource:        TalkResource
    params:          { eventId: $routeParams.eventId, talkId: $routeParams.talkId }
    onDeleteSuccess: -> $navigate.go("/events/edit/#{$routeParams.eventId}", 'slide')
    
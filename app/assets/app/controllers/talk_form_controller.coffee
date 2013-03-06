window.TalkFormCtrl = ($scope, $routeParams, FormResourceService, TalkResource) ->
  FormResourceService.bind 'talk', $scope, TalkResource, { eventId: $routeParams.eventId, talkId: $routeParams.talkId }
    
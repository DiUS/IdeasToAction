window.MemberCtrl = ($scope, MemberIdeaActionsResource) ->
  $scope.idea_actions = MemberIdeaActionsResource.query ->
    $('.loading').removeClass('loading')

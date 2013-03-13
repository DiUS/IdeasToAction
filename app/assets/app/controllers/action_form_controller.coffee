window.IdeaActionFormCtrl = ($scope, $routeParams, $navigate, FormResourceService, IdeaActionResource) ->
  FormResourceService.bind
    id:              'idea_action'
    scope:           $scope
    resource:        IdeaActionResource
    params:          { ideaActionId: $routeParams.ideaActionId }
    # onDeleteSuccess: -> $navigate.go('/talks/edit', 'slide')
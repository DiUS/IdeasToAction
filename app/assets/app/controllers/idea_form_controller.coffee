window.IdeaFormCtrl = ($scope, $routeParams, $navigate, FormResourceService, IdeaResource) ->
  FormResourceService.bind
    id:              'idea'
    scope:           $scope
    resource:        IdeaResource
    params:          { ideaId: $routeParams.ideaId }
    # onDeleteSuccess: -> $navigate.go('/talks/edit', 'slide')
window.ActionFormCtrl = ($scope, $routeParams, $navigate, FormResourceService, ActionResource) ->
  FormResourceService.bind
    id:              'action'
    scope:           $scope
    resource:        ActionResource
    params:          { actionId: $routeParams.actionId }
    # onDeleteSuccess: -> $navigate.go('/talks/edit', 'slide')
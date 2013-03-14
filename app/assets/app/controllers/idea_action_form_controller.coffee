window.IdeaActionFormCtrl = ($scope, $routeParams, $navigate, $rootScope, FormResourceService, IdeaActionResource) ->
  FormResourceService.bind
    id:              'ideaAction'
    scope:           $scope
    resource:        IdeaActionResource
    params:          { ideaId: $routeParams.ideaId, ideaActionId: $routeParams.ideaActionId }
    onDeleteSuccess: ->
      $navigate.go("/ideas/edit/#{$routeParams.ideaId}", 'slide')

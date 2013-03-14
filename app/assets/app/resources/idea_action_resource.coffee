angular.module('Actionman').factory('IdeaActionResource', ($resource) ->
  $resource('ideas/:ideaId/idea_actions/:ideaActionId',
    { ideadId: '@ideaId', ideaActionId: '@ideaActionId' },
    {
      update: { method: 'PUT' }
    })
)
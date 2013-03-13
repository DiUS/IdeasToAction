angular.module('Actionman').factory('IdeaActionResource', ($resource) ->
  $resource('/idea_actions/:ideaActionId',
    { ideaActionId: '@ideaActionId' },
    {
      update: { method: 'PUT' }
    })
)
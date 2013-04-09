angular.module('Actionman').factory('InteractionResource', ($resource) ->
  $resource("#{window.ENDPOINT}/idea_actions/:ideaActionId/interactions/:id", 
    { id: '@id', ideaActionId: '@idea_action_id' },
    {
      update: { method: 'PUT' }
    })
)
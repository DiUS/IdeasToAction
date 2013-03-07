angular.module('Actionman').factory('IdeaResource', ($resource) ->
  $resource('/ideas/:ideaId', 
    { ideaId: '@ideaId' },
    {
      update: { method: 'PUT' }
    })
)
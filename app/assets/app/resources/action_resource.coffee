angular.module('Actionman').factory('ActionResource', ($resource) ->
  $resource('/actions/:actionId', 
    { actionId: '@actionId' },
    {
      update: { method: 'PUT' }
    })
)
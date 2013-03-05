angular.module('Actionman').factory('EventResource', ($resource) ->
  $resource('/events/:eventId', 
    { eventId: '@eventId' },
    {
      update: { method: 'PUT' }
    })
)
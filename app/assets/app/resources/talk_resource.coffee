angular.module('Actionman').factory('TalkResource', ($resource) ->
  $resource('/events/:eventId/talks/:talkId', 
    { eventId: '@eventId', talkId: '@talkId' },
    {
      update: { method: 'PUT' }
    })
)
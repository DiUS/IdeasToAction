angular.module('Actionman').
  factory 'EventResource', ($resource) ->
    $resource '/events/:eventId', { eventId: '@eventId' },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
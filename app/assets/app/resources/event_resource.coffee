angular.module('Actionman').
  factory 'EventResource', ($resource) ->
    $resource "#{window.ENDPOINT}/events/:eventId", { eventId: '@eventId' },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
        more:
          method: 'GET'
          isArray: true
      }
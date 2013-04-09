angular.module('Actionman').
  factory 'IdeaResource', ($resource) ->
    $resource "#{window.ENDPOINT}/ideas/:ideaId", { ideaId: '@ideaId' },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
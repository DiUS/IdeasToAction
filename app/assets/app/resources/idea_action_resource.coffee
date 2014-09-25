angular.module('Actionman').
  factory 'IdeaActionResource', ($resource) ->
    $resource "#{window.ENDPOINT}/idea_actions/:ideaActionId", { ideaActionId: '@ideaActionId' },
      {
        complete:
          method: "PUT"
          isArray: false
      },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
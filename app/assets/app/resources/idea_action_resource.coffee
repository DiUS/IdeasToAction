angular.module('Actionman').
  factory 'IdeaActionResource', ($resource) ->
    $resource "#{window.ENDPOINT}/idea_actions/:ideaActionId", { ideaActionId: '@ideaActionId' },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
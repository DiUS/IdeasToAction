angular.module('Actionman').
  factory 'IdeaActionResource', ($resource) ->
    $resource '/idea_actions/:ideaActionId', { ideaActionId: '@ideaActionId' },
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
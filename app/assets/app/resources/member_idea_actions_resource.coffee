angular.module('Actionman').factory 'MemberIdeaActionsResource', ($resource) ->
  $resource "#{window.ENDPOINT}/member/idea_actions"
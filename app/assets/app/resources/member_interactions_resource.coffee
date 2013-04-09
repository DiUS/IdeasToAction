angular.module('Actionman').factory 'MemberInteractionsResource', ($resource) ->
  $resource "#{window.ENDPOINT}/member/interactions"
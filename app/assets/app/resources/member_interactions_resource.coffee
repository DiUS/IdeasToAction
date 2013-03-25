angular.module('Actionman').factory 'MemberInteractionsResource', ($resource) ->
  $resource '/member/interactions'
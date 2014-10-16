angular.module('Actionman').
  factory 'MemberResource', ($resource) ->
    $resource "#{window.ENDPOINT}/members/:memberId", {memberId: "@memberId"},
      {
        update:
          method: "PUT"
      }

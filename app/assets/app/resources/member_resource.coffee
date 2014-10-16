angular.module('Actionman').
  factory 'MemberResource', ($resource) ->
    $resource "/members/:memberId", {memberId: "@memberId"},
      {
        update:
          method: "PUT"
      }

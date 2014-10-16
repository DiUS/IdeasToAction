angular.module('Actionman').
  factory 'MemberResource', ($resource) ->
    $resource "/members/:id", {id: "@id"},
      {
        update:
          method: "PUT"
      }

angular.module('Actionman').
  factory 'TalkResource', ($resource) ->
    $resource '/talks', {},
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
angular.module('Actionman').
  factory 'TalkResource', ($resource) ->
    $resource "#{window.ENDPOINT}/talks", {},
      {
        mix:
          method: 'GET'
          isArray: false
          params:
            mix: true
      }
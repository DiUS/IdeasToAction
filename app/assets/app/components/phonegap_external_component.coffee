angular.module('Actionman').
  directive 'phonegapExternal', ->
    (scope, elm, attrs) -> 
      elm.bind 'click', -> 
        window.open attrs.phonegapExternal, "_system"
        false
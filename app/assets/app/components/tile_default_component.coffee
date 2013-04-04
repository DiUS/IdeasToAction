angular.module('Actionman').
  directive 'tileDefault', ->
    restrict: 'E'
    templateUrl: 'assets/views/tiles/default.html'
    replace: true
    scope: 
      title: '='
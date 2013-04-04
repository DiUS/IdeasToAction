angular.module('Actionman').
  directive 'tileCount', ->
    restrict: 'E'
    templateUrl: 'assets/views/tiles/count.html'
    replace: true
    scope: 
      count: '='
      title: '@'
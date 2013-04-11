angular.module('Actionman').
  directive 'search', ->
    restrict: 'E'
    scope:
      scroller: '='
    controller: SearchComponentCtrl
    templateUrl: 'assets/views/search/search.html'
    replace: true
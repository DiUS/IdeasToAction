angular.module('Actionman').
  directive 'tileFeatured', ->
    restrict: 'E'
    templateUrl: 'assets/views/tiles/featured.html'
    replace: true
    scope: 
      heading: '@'
      img: '='
      title: '='
      description: '='
angular.module('Actionman').
  directive('collapsible', () ->
    return {
      restrict: 'E',
      transclude: true,
      scope: {},
      link: ($scope, $element) -> 
        $scope.$parent.$watch $scope.collection_expr, (newValue, oldValue) ->
          $scope.collection = newValue || []

      controller: ($scope, $element) -> 
        $scope.expandCollapse = () -> $element.find('.items').slideToggle 300

        $scope.title = $element.attr('title')
        $scope.collection_expr = $element.attr('collection')
        $scope.itemTemplate = $element.attr('item-template')

      templateUrl: 'views/collapsible/collapsible.html',
      replace: true
    }
  )
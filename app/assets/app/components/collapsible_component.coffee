angular.module('Actionman').
  directive('collapsible', () ->
    return {
      restrict: 'E',
      transclude: true,
      scope: {},
      link: ($scope, $element) -> 
        $scope.$parent.$watch $scope.collection_expr, (newValue, oldValue) ->
          $scope.collection = newValue || []

      controller: window.CollapsibleCtrl,
      templateUrl: 'views/collapsible/collapsible.html',
      replace: true
    }
  )
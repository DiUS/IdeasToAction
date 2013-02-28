angular.module('Actionman').
  directive('collapsible', () ->
    return {
      restrict: 'E',
      transclude: true,
      scope: { },
      link: ($scope, $element) ->
        $scope.$parent.$watch $scope.collection_expr, (newValue, oldValue) ->
          $scope.collection = newValue || []
        $scope.$parent.$watch "#{$scope.collection_expr}.length", (newValue, oldValue) ->
          $element.find('.title sup').text(newValue);
          $scope.collection_length = newValue

      controller: window.CollapsibleCtrl,
      templateUrl: 'assets/views/collapsible/collapsible.html',
      replace: true
    }
  )
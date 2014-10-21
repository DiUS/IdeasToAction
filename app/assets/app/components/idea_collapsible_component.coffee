angular.module('Actionman').
  directive 'idea_collapsible', ->
    restrict: 'E'
    transclude: true
    scope:
      scroller: '='
    link: ($scope, $element) ->
      $scope.$parent.$watch $scope.collection_expr, (newValue, oldValue) ->
        $scope.collection = newValue || []
      $scope.$parent.$watch "#{$scope.collection_expr}.length", (newValue, oldValue) ->
        $element.find('.title sup').text(newValue);
        $scope.collection_length = newValue

    controller: window.CollapsibleCtrl
    templateUrl: 'assets/views/collapsible/idea_collapsible.html'
    replace: true

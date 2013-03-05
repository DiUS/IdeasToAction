angular.module('Actionman').
  directive 'bootstrapInput', ($compile) ->
    restrict: 'E',
    transclude: true,
    replace: true,
    scope: { },
    controller: window.BootstrapInputCtrl,
    templateUrl: 'assets/views/form/bootstrap_input.html',
    link: ($scope, elem, attr, ctrl) ->
      textField = $('input', elem).attr('ng-model', "$parent.#{$scope.model}")
      $compile(textField)($scope)
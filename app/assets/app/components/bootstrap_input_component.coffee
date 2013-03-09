angular.module('Actionman').
  directive 'bootstrapInput', ->
    restrict: 'E',
    replace: true,
    scope: {
      key: '@',
      description: '@',
      model: '=',
      error: '='
    },
    templateUrl: 'assets/views/form/bootstrap_input.html'
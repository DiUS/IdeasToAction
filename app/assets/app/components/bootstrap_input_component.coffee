angular.module('Actionman').
  directive 'bootstrapInput', ->
    restrict: 'E',
    replace: true,
    scope: {
      model: '=',
      key: '@',
      description: '@'
    },
    templateUrl: 'assets/views/form/bootstrap_input.html'
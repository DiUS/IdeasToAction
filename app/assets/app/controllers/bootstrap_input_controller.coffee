window.BootstrapInputCtrl = ($scope, $element) ->
  $scope.model = $element.attr('model')
  $scope.key = $element.attr('key')
  $scope.description = $element.attr('description')

window.MainCtrl = ($scope, $navigate, $location) ->
  $scope.navigate = $navigate

  Zepto('body').swipeRight () ->
    $scope.$apply('navigate.back()')

  $navigate.go($location.path(), 'none');
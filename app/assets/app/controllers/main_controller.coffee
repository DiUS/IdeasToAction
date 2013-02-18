
window.MainCtrl = ($scope, $navigate, $location) ->
  $scope.navigate = $navigate

  Zepto('body').swipeRight () ->
    window.history.go(-1)
    # $scope.$apply('navigate.back()')

  $navigate.go($location.path(), 'none');
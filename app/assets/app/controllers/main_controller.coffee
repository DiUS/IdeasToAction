
window.MainCtrl = ($scope, $navigate, $location) ->
  $scope.navigate = $navigate

#  $('body').bind 'swipeRight', ()->
#    $scope.$apply('navigate.back()')
  $navigate.go($location.path(), 'none');

window.MainCtrl = ($scope, $navigate) ->
  $scope.navigate = $navigate
  $('body').bind 'swipeRight', ()->
    $scope.$apply('navigate.back()')

  $navigate.go('/talks', 'slide');

 

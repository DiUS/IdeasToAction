
window.MainCtrl = ($scope, $navigate) ->
  $scope.$navigate = $navigate

  $('body').bind 'swipeRight', ()->
    $('#back-button').click()

  $scope.$navigate.go('/talks', 'slide');

 

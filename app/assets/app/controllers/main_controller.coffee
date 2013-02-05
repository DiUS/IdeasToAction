
window.MainCtrl = ($scope, $navigate) ->
  $('body').bind 'swipeRight', ()->
    $('#back-button').click()

  $navigate.go('/talks', 'slide');

 

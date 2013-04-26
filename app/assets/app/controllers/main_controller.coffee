window.MainCtrl = ($scope, $navigate, $location) ->
  $scope.navigate = $navigate

  #
  # Prevent double clicking issue with android phonegap
  # http://stackoverflow.com/questions/14982864/phonegap-2-4-0-with-android-4-2-strange-double-click-behaviour
  #
  last_click_time = new Date().getTime();
  document.addEventListener('click', (e) ->
      click_time = e['timeStamp'];
      if (click_time && (click_time - last_click_time) < 1000)
          e.stopImmediatePropagation();
          e.preventDefault();
          return false;
      last_click_time = click_time;
  , true)

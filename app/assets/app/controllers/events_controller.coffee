window.EventsCtrl = ($scope, $timeout, $navigate, EventResource) ->
  $scope.query = text: ''
  $scope.doSearch = ->
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 600
    false

  $scope.events = EventResource.mix()

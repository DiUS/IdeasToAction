window.TalksCtrl = ($scope, $timeout, $navigate, TalkResource) ->
  $scope.query = text: ''
  $scope.doSearch = ->
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 600
    false

  $scope.events = TalkResource.mix()

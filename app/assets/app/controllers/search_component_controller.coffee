window.SearchComponentCtrl = ($scope, $navigate, $timeout) ->
  $scope.doSearch = -> 
    $timeout ->
      $scope.scroller.scrollToPage(0, 200, 300)
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 400
    false
  
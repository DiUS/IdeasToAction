window.SearchComponentCtrl = ($scope, $navigate, $timeout) ->
  $scope.doSearch = -> 
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
      $timeout -> 
        $scope.scroller.scrollToPage(0, 0, 300)
      , 400
    , 400
    false
  
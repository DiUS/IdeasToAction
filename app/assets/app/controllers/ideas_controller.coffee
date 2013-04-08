window.IdeasCtrl = ($scope, $timeout, $navigate, IdeaResource) ->
  $scope.query = text: ''
  $scope.doSearch = ->
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 600
    false

  $scope.ideas = IdeaResource.mix()

window.IdeaActionsCtrl = ($scope, $timeout, $navigate, IdeaActionResource) ->
  $scope.query = text: ''
  $scope.doSearch = ->
    $timeout ->
      $navigate.swipeScope.clearAllPagesForward()
      $navigate.go("/found?query_text=#{$scope.query.text}", 'slide')
    , 600
    false

  $scope.ideas = IdeaActionResource.mix()

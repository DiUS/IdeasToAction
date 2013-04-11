window.TalksCtrl = ($scope, TalkResource) ->
  $scope.talks = TalkResource.mix()

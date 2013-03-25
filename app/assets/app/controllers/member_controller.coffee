window.MemberCtrl = ($scope, MemberInteractionsResource, $navigate) ->
  $scope.interactions = MemberInteractionsResource.query ->
    $('.loading').removeClass('loading')
    $navigate.swipeScope.refreshPageHeight()
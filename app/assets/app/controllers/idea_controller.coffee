window.IdeaCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json", { cache: dataCache }).success (data) -> 
      $scope.idea = data
      $scope.twitter = {
        url: "https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Fwww.ideasintoaction.com&text=Have a look at this idea!&tw_p=tweetbutton&url=http%3A%2F%2Fwww.ideasintoaction.com%2F%23%2Fideas%2F#{$scope.ideaId}"
      }
      $('.loading').removeClass('loading')
      $navigate.swipeScope.refreshPageHeight()
      callback() if callback?

  $scope.update()
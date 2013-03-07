window.IdeaCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json", { cache: dataCache }).success (data) -> 
      $scope.idea = data
      talk_title = $scope.idea.talks[0].title
      idea_short_url = $scope.idea.idea_url
      $scope.twitter = {
        url: "https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Fwww.ideasintoaction.com&text=#{talk_title}&tw_p=tweetbutton&url=#{idea_short_url}"
      }
      $('.loading').removeClass('loading')
      $navigate.swipeScope.refreshPageHeight()
      callback() if callback?

  $scope.update()
window.IdeaCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json", { cache: dataCache }).success (data) -> 
      $scope.idea = data
      $scope.talk_title = $scope.idea.talks[0].title
      $('.loading').removeClass('loading')
      $navigate.swipeScope.refreshPageHeight()
      callback() if callback?

      # assyncronously loading twitter button beacuase calling external service
      $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}/show_idea_url", { cache: dataCache }).success (data) ->
        $scope.idea_short_url = data.idea_url
        $scope.twitter = {
          url: "https://twitter.com/intent/tweet?original_referer=#{window.ENDPOINT}&text=#{$scope.talk_title}&tw_p=tweetbutton&url=#{$scope.idea_short_url}"
        }

  $scope.update()
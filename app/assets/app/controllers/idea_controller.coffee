window.IdeaCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.ideaId = $routeParams.ideaId

  $scope.identityClass = (idea) ->
    return '' unless idea
    "idea-#{idea.id}"

  $scope.update = (callback) ->
    $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}.json", { cache: dataCache }).success (data) -> 
      $scope.idea = data
      $scope.talk_title = $scope.idea.talks[0].title

      $scope.$watch 'idea.interactions', ->
        $scope.idea.reactions = $scope.idea.interactions.filter (interaction) -> interaction.reaction_text?

      $('.loading').removeClass('loading')
      callback() if callback?

      # assyncronously loading twitter button beacuase calling external service
      $http.get("#{window.ENDPOINT}/ideas/#{$scope.ideaId}/show_idea_url", { cache: dataCache }).success (data) ->
        $scope.idea_short_url = data.idea_url
        $scope.twitter = url: "https://twitter.com/intent/tweet?original_referer=#{window.ENDPOINT}&text=#{encodeURIComponent($scope.talk_title)}&tw_p=tweetbutton&url=#{$scope.idea_short_url}"
        $scope.twitter.isApple = true if (/iphone|ipad/gi).test(navigator.appVersion)

  $scope.showNewIdeaActionDialog = false

  $scope.tweet = ->
    if $scope.twitter.isApple?
      window.plugins.twitter.isTwitterAvailable -> 
        window.plugins.twitter.composeTweet(
          ->, 
          ->, 
          "#{$scope.talk_title} #{$scope.idea_short_url}"
        )

  $scope.createNewIdeaAction = (idea) ->
    $("#new-idea-action-dialog").scope().startNewIdeaAction(idea)
    $scope.showNewIdeaActionDialog = true
    $navigate.swipeScope.resetToTop()

  $scope.update()
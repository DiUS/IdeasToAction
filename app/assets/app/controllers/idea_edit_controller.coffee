window.IdeaEditCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->

  $scope.scrollToPosition = ($event) ->
    element = angular.element($event.toElement)[0];
    setTimeout ->
      offset = 100
      $('swipe-view').scope().scroll.scrollElementToTop(element, offset, 200)
    , 500  

  $scope.startNewIdea = (talk) ->
    $scope.idea = { description: '', talks: [ ], actions: [ ] }
    $scope.idea.talks.push(talk) if talk
    $scope.newActionDescription = ''
    $scope

  $scope.cancel = ->
    $navigate.swipeScope.resetToTop()
    $scope.$parent.showNewIdeaDialog = false

  $scope.addNewAction = ->
    return unless @newActionDescription.length > 0
    @idea.actions.push({ description: @newActionDescription })
    @newActionDescription = ''

  $scope.removeAction = (action)->
    @idea.actions.splice(action, 1)

  $scope.validIdea = ->
    (@idea.actions.length > 0) and (@idea.description)

  $scope.retrieveTalkById = (talkId) ->
    $http.get("#{window.ENDPOINT}/talks/#{talkId}.json", { cache: dataCache }).success (talk) -> 
      $scope.idea.talks.push(talk)

  $scope.submitIdea = (idea) ->
    $http.post("#{window.ENDPOINT}/ideas", idea).success (ideaWithId) -> 
      dataCache.removeAll()
      $("#talk").scope().update().success (data)->
        $('body').scope().navigate.go("/ideas/#{ideaWithId.id}")
        $navigate.swipeScope.resetToTop()
        $scope.$parent.showNewIdeaDialog = false

  $scope.startNewIdea($scope.$parent.talk)

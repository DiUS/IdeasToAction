window.IdeaActionEditCtrl = ($scope, $http, $routeParams, $navigate, dataCache) ->
  $scope.startNewIdeaAction = (ideaId) ->
    $scope.idea_action = { description: '', target_date: '', idea_id: null }
    $scope.idea_action.idea_id = ideaId if ideaId
    $scope.submitted = false
    $scope

  $scope.cancel = ->
    $navigate.swipeScope.resetToTop()
    $scope.$parent.showNewIdeaActionDialog = false

  $scope.validIdeaAction = ->
    @idea_action.description && @idea_action.target_date && !$scope.submitted

  $scope.submitIdeaAction = (idea_action) ->
    $scope.submitted = true
    $http.post("#{window.ENDPOINT}/idea_actions", idea_action).success (ideaActionWithId) ->
      dataCache.removeAll()
      $("#idea").scope().update().success () ->
        $('body').scope().navigate.go("/ideas/#{ideaActionWithId.idea_id}")
        $navigate.swipeScope.resetToTop()
        $scope.$parent.showNewIdeaActionDialog = false

  $scope.startNewIdeaAction($scope.$parent.ideaId)

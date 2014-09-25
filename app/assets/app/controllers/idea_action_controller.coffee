window.IdeaActionCtrl = ($scope, $http, $element) ->
  $scope.doneIt = (ideaActionId) ->
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')
    $button.addClass('disabled')
    $http.put("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/complete")
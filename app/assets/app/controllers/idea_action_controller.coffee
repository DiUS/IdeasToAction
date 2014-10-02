window.IdeaActionCtrl = ($scope, $http, $element) ->
  $scope.doneIt = (idea_action) ->
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')
    $button.addClass('disabled')
    $http.put("#{window.ENDPOINT}/idea_actions/#{idea_action.id}/complete").success ->
      idea_action.completion_date = new Date()
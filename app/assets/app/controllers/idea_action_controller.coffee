window.IdeaActionCtrl = ($scope, $http, $element) ->
  $scope.doneIt = (ideaActionId) ->
    alert "I've just done action #{ideaActionId}!  Stand by for proper implementation."
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')

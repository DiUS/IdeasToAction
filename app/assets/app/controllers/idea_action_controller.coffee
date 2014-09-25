window.IdeaActionCtrl = ($scope, $http, $element, IdeaActionResource) ->
  $scope.doneIt = (ideaAction) ->
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')

#    ideaAction.complete()

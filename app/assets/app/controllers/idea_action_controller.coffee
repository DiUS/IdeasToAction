window.IdeaActionCtrl = ($scope, $http, $element, $routeParams, dataCache) ->
  $scope.doneIt = (ideaActionId) ->
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')
    $http.post("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/doneIt.json").success (data) ->
      dataCache.removeAll()
      $('#idea').scope().update () ->
        setTimeout( () ->
          $("#reaction-#{ideaActionId}").slideToggle 300
        , 300)
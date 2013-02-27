window.ReactionCtrl = ($scope, $http, $routeParams, $element, dataCache) ->
  $textarea = $element.find('textarea')
  $textarea.on 'click', () ->
    setTimeout () ->
      offset = 150
      $('swipe-view').scope().scroll.scrollElementToTop($textarea[0], offset, 200)
    , 500

  $scope.react = (ideaId, actionId) -> 
    $button = $element.find('.submit-reaction')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')
    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", { text: $("#reaction-#{actionId}").find('textarea').val() }).success (data) ->
      $("#reaction-#{actionId}").slideToggle 300, () ->
        dataCache.removeAll()
        $("#idea").scope().update()
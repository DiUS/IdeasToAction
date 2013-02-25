window.ReactionCtrl = ($scope, $http, $routeParams, $element, dataCache) ->
  $element.find('textarea').focus () ->
    $('body').animate { scrollTop: $(this).offset().top - 50, 300 }, () ->
      
  $scope.react = (ideaId, actionId) -> 
    $button = $element.find('.submit-reaction')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')
    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", { text: $("#reaction-#{actionId}").find('textarea').val() }).success (data) ->
      $("#reaction-#{actionId}").slideToggle 300, () ->
        dataCache.removeAll()
        $("#idea").scope().update()
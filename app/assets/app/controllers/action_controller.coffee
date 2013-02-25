window.ActionCtrl = ($scope, $http, $element, $routeParams, dataCache) ->
  $scope.doneIt = (actionId) -> 
    $button = $element.find('.done-it')
    return if $button.hasClass('disabled')

    $button.addClass('disabled')
    $http.post("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").success (data) ->
      dataCache.removeAll()
      $('#idea').scope().update () ->
        setTimeout( () ->
          $("#reaction-#{actionId}").slideToggle 300
        , 300)
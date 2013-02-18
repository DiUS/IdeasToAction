window.ActionCtrl = ($scope, $http, $routeParams, dataCache) ->
  $scope.doneIt = (actionId) -> 
    $http.post("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").success (data) ->
      dataCache.removeAll()
      $('#idea').scope().update () ->
        setTimeout( () ->
          $("#reaction-#{actionId}").slideToggle 300
        , 300)
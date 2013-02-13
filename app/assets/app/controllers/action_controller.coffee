window.ActionCtrl = ($scope, $http, $routeParams) ->
  $scope.doneIt = (actionId, ideaId) -> 
    $http.post("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").success (data) ->
      $('#idea').scope().update () ->
        setTimeout( () ->
          $("#reaction-#{ideaId}").slideToggle 300
        , 300)
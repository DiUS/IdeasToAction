window.ActionCtrl = ($scope, $http, $routeParams) ->
  $scope.doneIt = (actionId) -> 
    $http.post("#{window.ENDPOINT}/actions/#{actionId}/doneIt.json").success (data) ->
      $('#idea').scope().update()
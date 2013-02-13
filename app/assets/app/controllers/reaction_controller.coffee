window.ReactionCtrl = ($scope, $http, $routeParams) ->
  $scope.react = (ideaId, actionId) -> 
    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", {text: $("#reaction-#{actionId}").find('textarea').val()}).success (data) ->
      $("#reaction-#{actionId}").slideToggle 300, () ->
        $("#idea").scope().update()
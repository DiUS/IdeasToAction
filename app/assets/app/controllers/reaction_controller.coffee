window.ReactionCtrl = ($scope, $http, $routeParams) ->
  $scope.react = (ideaId) -> 
    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", {text: $("#reaction-#{ideaId}").find('textarea').val()}).success (data) ->
      $("#reaction-#{ideaId}").slideToggle 300, () ->
        $("#idea").scope().update()
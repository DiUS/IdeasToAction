window.ReactionCtrl = ($scope, $http, $routeParams) ->
  $scope.react = (ideaId) -> 
    $http.post("#{window.ENDPOINT}/ideas/#{ideaId}/react.json", {text: $('#reaction').val()}).success (data) ->
      $("#idea").scope().update()
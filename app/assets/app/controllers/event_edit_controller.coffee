window.EventsEditCtrl = ($scope, $http, $navigate) ->
  $http.get("#{window.ENDPOINT}/events").success (data) -> 
    $scope.events = data
    $navigate.swipeScope.refreshPageHeight()
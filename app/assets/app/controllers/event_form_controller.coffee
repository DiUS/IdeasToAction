window.EventFormCtrl = ($scope, $routeParams, EventResource) ->
  $scope.event = new EventResource()

  success = (event) -> 
    $scope.errors = null
    $scope.event = event || null

  error = (response) -> 
    $scope.errors = response.data.errors

  # get if id is provided
  $scope.event.$get { eventId: $routeParams.eventId }, success, error if $routeParams.eventId?

  $scope.create = -> $scope.event.$save   success, error
  $scope.update = -> $scope.event.$update success, error
  $scope.delete = -> $scope.event.$delete success, error
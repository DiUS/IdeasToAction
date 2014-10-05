window.AuthCtrl = ($scope, $http, $location, $routeParams, dataCache) ->

  $scope.loginForm = {}
  $scope.memberSession = {errorMsg: null, id: null, email: null, loggedIn: undefined}

  $scope.$watch (->
    $location.path()
  ), ->
    $http.get("#{window.ENDPOINT}/member_sessions/check.json").success (data) ->
      $scope.memberSession.loggedIn = data.admin_authenticated
      if $scope.memberSession.loggedIn
        $scope.memberSession.id = data.id
        $scope.memberSession.email = data.email

  $scope.login = ->
    $http.post("#{window.ENDPOINT}/member_sessions", $scope.loginForm).
    success((data) ->
      $scope.memberSession = {errorMsg: null, id: data.id, email: data.email, loggedIn: true}
      $location.path("/home")).
    error (data) ->
      $scope.memberSession.errorMsg = data.error

  $scope.logout = ->
    $http.delete("#{window.ENDPOINT}/member_sessions/#{$scope.memberSession.id}").success (data) ->
      $scope.memberSession = {errorMsg: null, id: null, email: null, loggedIn: false}

  $scope.loggedInStatusDetermined = ->
    $scope.memberSession.loggedIn?

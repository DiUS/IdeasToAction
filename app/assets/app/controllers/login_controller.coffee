window.LoginCtrl = ($rootScope, $scope, $http, $location) ->
  $scope.loginForm =
    email: ""
    password: ""
    remember_me: true

  $scope.memberSession = {errorMsg: null, id: null, email: null, loggedIn: undefined}

  $rootScope.member = {}
  $scope.submit = ->
    $scope.loginForm.password = "constant_hardcoded_password"
    $scope.loginForm.remember_me = true
    $http.post("#{window.ENDPOINT}/member_sessions", $scope.loginForm).success((member_data) ->
      $rootScope.member = member_data
      $scope.memberSession = {errorMsg: null, id: member_data.id, email: member_data.email, loggedIn: true}
      $location.path("/home")
    ).error (data) ->
      $scope.memberSession = {errorMsg: data.error, id: null, email: null, loggedIn: undefined}

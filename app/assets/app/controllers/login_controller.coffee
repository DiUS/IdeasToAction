window.LoginCtrl = ($rootScope, $scope, $http, $location, MemberSession, LoginService) ->
  $scope.loginForm =
    email: ""
    password: ""
    remember_me: true

  $scope.memberSession = MemberSession

  $scope.submit = ->
    LoginService.login($scope.loginForm).then ( (session)->
      $scope.memberSession = session
      window.localStorage.setItem "TEDXLoginEmail", session.email
      $location.path("/home")
    ), (res) ->
      MemberSession.create res.data.error, null, null, undefined

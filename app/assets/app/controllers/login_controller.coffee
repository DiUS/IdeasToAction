window.LoginCtrl = ($rootScope, $scope, $timeout, $http, $location, MemberSession, LoginService) ->
  $scope.loginForm =
    email: ""
    password: ""
    remember_me: true

  $scope.memberSession = MemberSession

  $scope.submit = ->
    LoginService.login($scope.loginForm).then ( (session)->
      $scope.memberSession = session
      window.localStorage.setItem "TEDXLoginEmail", session.email
      $timeout (->
        $location.path("/home").replace()
      ), 1
    ), (res) ->
      MemberSession.create res.data.error, null, null, undefined

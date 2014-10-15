angular.module('Actionman').
  factory "LoginService", ($http, MemberSession) ->
    authService = {}
    authService.login = (loginForm) ->
      loginForm.password = "constant_hardcoded_password"
      loginForm.remember_me = true

      $http.post("#{window.ENDPOINT}/member_sessions", loginForm).then ((res) ->
        MemberSession.create null, res.data.id, res.data.email, true
      )

    authService
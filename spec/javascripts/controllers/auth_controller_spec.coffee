describe 'Actionman', () ->

  describe 'AuthCtrl', () ->
    loginCredentials = { email: "ted@x.com", password: "ted" }
    successloginResponse = { success: true, id: 1, email: "ted@x.com" }
    successCheckResponse = { admin_authenticated: true, id: 1, email: "ted@x.com" }
    notAuthenticatedCheckResponse = { admin_authenticated: false }
    loggedInSessionData = { errorMsg: null, id: successloginResponse.id, email: successloginResponse.email, loggedIn: true }
    blankSessionData = { errorMsg: null, id: null, email: null, loggedIn: undefined }
    loggedOutSessionData = { errorMsg: null, id: null, email: null, loggedIn: false }

    scope = null
    ctrl = null
    httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

#      httpBackend.expectPOST("#{window.ENDPOINT}/member_sessions", loginCredentials).respond(successloginResponse)
#      httpBackend.expectGET("#{window.ENDPOINT}/member_sessions/check.json").respond(successCheckResponse)
#      httpBackend.expectDELETE("#{window.ENDPOINT}/member_sessions/#{successloginResponse.id}").respond(blankSessionData)

      scope = $rootScope.$new()
      ctrl = $controller( 'AuthCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache') })

    describe "#login", () ->

      beforeEach () ->
        httpBackend.expectPOST("#{window.ENDPOINT}/member_sessions", loginCredentials).respond(successloginResponse)
        httpBackend.expectGET("#{window.ENDPOINT}/member_sessions/check.json").respond(successCheckResponse)
        scope.loginForm = loginCredentials

      it "should expose the login method", () ->
        scope.login()
        httpBackend.flush()
        expect(scope.login).toBeDefined()

      it "should set session variables correctly", () ->
        scope.login()
        expect(scope.memberSession).toEqual(blankSessionData)
        httpBackend.flush()
        expect(scope.memberSession).toEqual(loggedInSessionData)

    describe "#logout", () ->

      beforeEach () ->
        httpBackend.expectDELETE("#{window.ENDPOINT}/member_sessions/#{successloginResponse.id}").respond(blankSessionData)
        httpBackend.expectGET("#{window.ENDPOINT}/member_sessions/check.json").respond(notAuthenticatedCheckResponse)

        scope.memberSession = loggedInSessionData

      it "should expose the logout method", () ->
        scope.logout()
        httpBackend.flush()
        expect(scope.logout).toBeDefined()

      it "should clear the session variables", () ->
        scope.logout()
        httpBackend.flush()
        expect(scope.memberSession).toEqual(loggedOutSessionData)

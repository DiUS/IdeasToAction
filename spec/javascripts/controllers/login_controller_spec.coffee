describe 'LoginCtrl', ->
  scope = null
  ctrl = null
  httpBackend = null
  location = null

  loginForm = { email: "member@example.com", password: "constant_hardcoded_password", remember_me: true }
  successloginResponse = { success: true, id: 1, email: loginForm.email }
  errorloginResponse = { success: false, error: 'invalid email' }
  blankSessionData = { errorMsg: null, id: null, email: null, loggedIn: undefined }
  loggedInSessionData = {errorMsg: null, id: 1, email: loginForm.email, loggedIn: loginForm.remember_me}

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $location) ->
    httpBackend = _$httpBackend_
    scope = $rootScope.$new()
    location = $location
    ctrl = $controller( 'LoginCtrl', { $scope: scope } )
    scope.loginForm = loginForm
    $location.path = jasmine.createSpy('path')

  describe '#submit', ->

    it 'should expose the login method', ->
      expect(scope.submit).toBeDefined()

    describe 'when successful', ->
      beforeEach ->
        httpBackend.expectPOST("#{window.ENDPOINT}/member_sessions", loginForm).respond(successloginResponse)

      it 'should set session variables correctly', ->
        scope.submit()
        expect(scope.memberSession).toEqual(blankSessionData)
        httpBackend.flush()
        expect(scope.memberSession).toEqual(loggedInSessionData)

      it 'should navigate to the home page', ->
        scope.submit()
        httpBackend.flush()
        expect(location.path).toHaveBeenCalledWith('/home')

    describe 'when error', ->
      beforeEach ->
        httpBackend.expectPOST("#{window.ENDPOINT}/member_sessions", loginForm).respond(433, errorloginResponse)

      it 'should not navigate to the home page', ->
        scope.submit()
        httpBackend.flush()
        expect(location.path).not.toHaveBeenCalledWith('/home')

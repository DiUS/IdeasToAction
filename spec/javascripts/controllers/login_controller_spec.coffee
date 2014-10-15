describe 'LoginCtrl', ->
  scope = null
  ctrl = null
  location = null
  q = null
  deferred = null
  LoginService = null

  loginForm = { email: "member@example.com", password: "constant_hardcoded_password", remember_me: true }
  MemberSession = { errorMsg: null, id: 1, email: loginForm.email, loggedIn: loginForm.remember_me }

  beforeEach inject ($rootScope, $controller, $location, $q) ->
    scope = $rootScope.$new()
    location = $location
    q = $q

    $location.path = jasmine.createSpy('path')

    LoginService =
      login: (loginForm) ->
        deferred = q.defer()
        deferred.resolve(MemberSession)
        deferred.promise

    spyOn(LoginService, 'login').andCallThrough()
    spyOn(window.localStorage, 'setItem')

    ctrl = $controller( 'LoginCtrl', { $scope: scope, LoginService: LoginService, MemberSession: MemberSession } )
    scope.loginForm = loginForm

  describe '#submit', ->
    beforeEach ->
      scope.submit()
      scope.$root.$digest()

    it 'should expose the login method', ->
      expect(scope.submit).toBeDefined()

    it 'should call the login service', ->
      expect(LoginService.login).toHaveBeenCalledWith(loginForm)

    it 'should set session variables correctly', ->
      expect(scope.memberSession).toEqual(MemberSession)

    it 'should navigate to the home page', ->
      expect(location.path).toHaveBeenCalledWith('/home')

    it 'should store email in the local storage', ->
      expect(window.localStorage.setItem).toHaveBeenCalledWith('TEDXLoginEmail', loginForm.email)

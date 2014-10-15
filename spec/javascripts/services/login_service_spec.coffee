describe 'LoginService', ->
  loginService = null
  memberSession = null
  httpBackend = null
  loginForm = { email: 'member@example.com', password: '', remember_me: undefined }
  loginResponse = { email: loginForm.email, id: 1 }

  beforeEach module "Actionman", () ->

  beforeEach inject (_$httpBackend_, LoginService, MemberSession) ->
    httpBackend = _$httpBackend_
    loginService = LoginService
    memberSession = MemberSession
    window.ENDPOINT = 'window_endpoint'
    httpBackend.expectPOST("#{window.ENDPOINT}/member_sessions").respond(loginResponse)

  describe '#login', ->
    beforeEach ->
      memberSession.create = jasmine.createSpy('create')
      loginService.login(loginForm)
      httpBackend.flush()

    it 'sets hardcoded password and remember_be', ->
      expect(loginForm.password).toBe('constant_hardcoded_password')
      expect(loginForm.remember_me).toBe(true)

    it 'created a member session', ->
      expect(memberSession.create).toHaveBeenCalledWith(null, 1, 'member@example.com', true)

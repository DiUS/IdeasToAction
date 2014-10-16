describe 'MemberCtrl', ->
  httpBackend = null
  scope = null
  emailError = {errors: email: ['email is invalid']}

  beforeEach module('Actionman')

  beforeEach inject (_$httpBackend_, $rootScope, $controller, MemberIdeaActionsResource, MemberSession, MemberResource) ->
    httpBackend = _$httpBackend_
    scope = $rootScope.$new()
    window.ENDPOINT = 'window_endpoint'
    MemberSession.id = 3
    spyOn(MemberIdeaActionsResource, 'query').andReturn([])
    spyOn(window.localStorage, 'setItem').andCallThrough()

    $controller 'MemberCtrl', { $scope: scope, MemberIdeaActionsResource: MemberIdeaActionsResource, MemberSession: MemberSession,  MemberResource, MemberResource }

  describe '#updateEmail', ->
    it 'should be defined', ->
      expect(scope.updateEmail).toBeDefined()

    describe 'when successful', ->
      beforeEach ->
        httpBackend.expectPUT("#{window.ENDPOINT}/members/3").respond({})
        scope.updateEmail()
        httpBackend.flush()

      it 'should set email on local storage', ->
        expect(window.localStorage.setItem).toHaveBeenCalled()

      it 'should flag the success', ->
        expect(scope.emailChangeError).toBeFalsy()
        expect(scope.emailChangeSuccess).toBeTruthy()

    describe 'when error', ->
      beforeEach ->
        httpBackend.expectPUT("#{window.ENDPOINT}/members/3").respond(422, emailError)
        scope.updateEmail()
        httpBackend.flush()

      it 'should flag the error', ->
        expect(scope.emailChangeError).toBeTruthy()
        expect(scope.emailChangeSuccess).toBeFalsy()

      it 'should expose email error', ->
        expect(scope.emailChangeError).toBe('email is invalid')

describe 'ActionmanApp', ()->

  describe 'MemberCtrl', () -> 
    memberData = {}
    actionsData = [ { description: 'Examine your own body language in different social situations.'} ]
    reactionsData = [ { text: 'that was a good action'} ]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectGET("#{window.ENDPOINT}/member.json").
            respond(memberData)

      $httpBackend.expectGET("#{window.ENDPOINT}/member/reactions.json").
            respond(reactionsData)

      $httpBackend.expectGET("#{window.ENDPOINT}/member/actions.json").
            respond(actionsData)

      scope = $rootScope.$new()
      ctrl = $controller( 'MemberCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache') })

    it 'should create "member" model obtained restfully', () ->
      expect(scope.member).toBeUndefined()
      $httpBackend.flush()
      expect(scope.member).toEqual(memberData);
    
    it 'should create "actions" in "member" model obtained restfully', () ->
      expect(scope.member).toBeUndefined()
      $httpBackend.flush()
      expect(scope.member.actions).toEqual(actionsData);

    it 'should create "reactions" in "member" model obtained restfully', () ->
      expect(scope.member).toBeUndefined()
      $httpBackend.flush()
      expect(scope.member.reactions).toEqual(reactionsData);
describe 'ActionmanApp', ()->

  describe 'TalkCtrl', () -> 
    talkData = { title: 'Amy Cuddy: Your body language shapes who you are'}
    ideaData = [
                  { body: 'Body language affects how others see us, but it may also change how we see ourselves.'},
                  { body: '"power posing” can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
                ]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1/talks/1.json").respond(talkData)
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1/talks/1/ideas.json").respond(ideaData)
      scope = $rootScope.$new()
      ctrl = $controller( 'TalkCtrl', { $scope: scope, $routeParams: { talkId: 1, eventId: 1 }, dataCache: $cacheFactory('fake cache') })

    it 'should set the talkId correctly', () ->
      $httpBackend.flush()
      expect(scope.talkId).toEqual(1);

    it 'should create "talk" model obtained restfully', () ->
      expect(scope.talk).toBeUndefined()
      $httpBackend.flush()
      expect(scope.talk).toEqual(talkData);
    
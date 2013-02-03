describe 'ActionmanApp', ()->

  describe 'TalkCtrl', () -> 
    talkData = { 
                title: 'Amy Cuddy: Your body language shapes who you are', 
                ideas: [
                  { body: 'Body language affects how others see us, but it may also change how we see ourselves.'},
                  { body: '"power posing” can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
                ]
              }

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/talks/1.json").
            respond(talkData)
      scope = $rootScope.$new()
      ctrl = $controller( 'TalkCtrl', { $scope: scope, $routeParams: { talkId: 1 } })

    it 'should set the talkId correctly', () ->
      expect(scope.talkId).toBeUndefined
      $httpBackend.flush()
      expect(scope.talkId).toEqual(1);

    it 'should create "talk" model obtained restfully', () ->
      expect(scope.talk).toBeUndefined
      $httpBackend.flush()
      expect(scope.talk).toEqual(talkData);
    
describe 'ActionmanApp', ()->

  describe 'TalksCtrl', () -> 
    talksData = [{ 
                title: 'Amy Cuddy: Your body language shapes who you are', 
                description: 'Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy shows how "power posing" -- standing in a posture of confidence, even when we don\'t feel confident -- can affect testosterone and cortisol levels in the brain, and might even have an impact on our chances for success.'
                ideas: [
                  { body: 'Body language affects how others see us, but it may also change how we see ourselves.'},
                  { body: '"power posing” can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
                ]
              },
              { 
                title: 'Steve Jobs: How to live before you die', 
                description: 'At his Stanford University commencement speech, Steve Jobs, CEO and co-founder of Apple and Pixar, urges us to pursue our dreams and see the opportunities in life\'s setbacks -- including death itself.'
                ideas: [
                  { body: 'Idea 1'},
                  { body: 'Idea 2'}
                ]
              }]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1/talks.json").
            respond(talksData)
      scope = $rootScope.$new()
      ctrl = $controller( 'TalksCtrl', { $scope: scope, $routeParams: { eventId: 1 }, dataCache: $cacheFactory('fake cache') })

    it 'should create "talks" model with talks obtained restfully', () ->
      expect(scope.talks).toBeUndefined()
      $httpBackend.flush()
      expect(scope.talks).toEqual(talksData);
    
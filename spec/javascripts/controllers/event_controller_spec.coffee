describe 'ActionmanApp', ()->

  describe 'EventCtrl', () -> 
    eventData = { name: 'Tedex'}

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1.json").
            respond(eventData)
      scope = $rootScope.$new()
      ctrl = $controller( 'EventCtrl', { $scope: scope, $routeParams: { eventId: 1 } })

    it 'should set the eventId correctly', () ->
      expect(scope.eventId).toBeUndefined
      $httpBackend.flush()
      expect(scope.eventId).toEqual(1);

    it 'should create "event" model obtained restfully', () ->
      expect(scope.event).toBeUndefined
      $httpBackend.flush()
      expect(scope.event).toEqual(eventData);
    
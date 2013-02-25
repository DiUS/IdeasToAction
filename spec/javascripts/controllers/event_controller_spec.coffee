describe 'Actionman', ()->

  beforeEach(module('Actionman')) 

  describe 'EventCtrl', () -> 
    eventData = { name: 'Tedex'}
    ideaData = [{body: 'stuff'}]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1.json").respond(eventData)
      $httpBackend.expectGET("#{window.ENDPOINT}/events/1/ideas.json").respond(ideaData)
      $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }
      scope = $rootScope.$new()
      ctrl = $controller( 'EventCtrl', { $scope: scope, $routeParams: { eventId: 1 }, $navigate, dataCache: $cacheFactory('fake cache') })

    it 'should set the eventId correctly', () ->
      $httpBackend.flush()
      expect(scope.eventId).toEqual(1);

    it 'should create "event" model obtained restfully', () ->
      expect(scope.event).toBeUndefined()
      $httpBackend.flush()
      expect(scope.event).toEqual(eventData);

    it 'should create "ideas" model obtained restfully', () ->
      expect(scope.ideas).toBeUndefined()
      $httpBackend.flush()
      expect(scope.ideas).toEqual(ideaData);
    
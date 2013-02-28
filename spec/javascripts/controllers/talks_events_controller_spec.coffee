describe 'Actionman', ()->

  beforeEach(module('Actionman'))

  describe 'TalksEventsCtrl', () -> 
    eventsData = [{ name: 'Tedex'}]
    talksData = [{description: 'stuff'}]

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("#{window.ENDPOINT}/events.json").respond(eventsData)
      $httpBackend.expectGET("#{window.ENDPOINT}/talks.json").respond(talksData)
      scope = $rootScope.$new()

      $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }

      ctrl = $controller( 'TalksEventsCtrl', { $scope: scope, $routeParams: { }, $navigate, dataCache: $cacheFactory('fake cache') })

    it 'should set the events correctly', () ->
      expect(scope.events).toBeUndefined()
      $httpBackend.flush()
      expect(scope.events).toEqual(eventsData);

    it 'should set the talks correctly', () ->
      expect(scope.talks).toBeUndefined()
      $httpBackend.flush()
      expect(scope.talks).toEqual(talksData)
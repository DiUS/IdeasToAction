describe 'TalkCtrl', -> 
  beforeEach module('Actionman')
  ideaData = [
                { description: 'Body language affects how others see us, but it may also change how we see ourselves.'},
                { description: '"power posing” can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
              ]

  talkData = { title: 'Amy Cuddy: Your body language shapes who you are', ideas: ideaData}

  scope = null
  ctrl = null
  navigate = null
  $httpBackend = null

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $navigate, $cacheFactory) ->
    navigate = $navigate
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET("#{window.ENDPOINT}/events/1/talks/1.json").respond(talkData)
    $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }
    scope = $rootScope.$new()
    ctrl = $controller( 'TalkCtrl', { $scope: scope, $routeParams: { talkId: 1, eventId: 1 }, $navigate, dataCache: $cacheFactory('fake cache') })

  it 'should set the talkId correctly', ->
    $httpBackend.flush()
    expect(scope.talkId).toEqual(1);

  it 'should fetch the talk from the server', ->
    expect(scope.talk).toBeUndefined()
    $httpBackend.flush()
    expect(scope.talk).not.toBeUndefined()

  it 'should refresh the page height', ->
    $httpBackend.flush()
    expect(navigate.swipeScope.refreshPageHeight).toHaveBeenCalled()
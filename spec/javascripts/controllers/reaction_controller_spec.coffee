describe 'ReactionCtrl', -> 

  ideaActionId = 1
  scope = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    window.ENDPOINT = 'window_endpoint'

    $httpBackend.expectPOST("#{window.ENDPOINT}/idea_actions/#{ideaActionId}/react.json", {text: 'my reaction'}).respond({})

    scope = $rootScope.$new()
    $controller( 'ReactionCtrl', { $scope: scope, dataCache: $cacheFactory('fake cache') })

  it 'should be in process when reacting', ->
    scope.reactionText = 'my reaction'
    scope.inProgress = false
    scope.react(ideaActionId)
    expect(scope.inProgress).toBeTruthy()


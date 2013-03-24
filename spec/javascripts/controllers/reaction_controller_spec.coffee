describe 'ReactionCtrl', -> 

  $scope = null
  Interaction = null

  beforeEach inject ($httpBackend, $rootScope, $controller, $cacheFactory) ->
    resource = reaction_text: null, $update: jasmine.createSpy('$update')

    Interaction = 
      resource: jasmine.createSpy('resource').andCallFake -> resource

    $scope = $rootScope.$new()
    $controller 'ReactionCtrl', { $scope: $scope, Interaction: Interaction, dataCache: $cacheFactory('fake cache') }

  it 'should be in process when reacting', ->
    $scope.inProgress = false
    $scope.react()
    expect($scope.inProgress).toBeTruthy()

  it 'should set the reaction text', ->
    $scope.reactionText = 'my lovely text'
    $scope.react()
    expect(Interaction.resource().reaction_text).toEqual('my lovely text')

  it 'should update the interaction', ->
    $scope.react()
    expect(Interaction.resource().$update).toHaveBeenCalled()

describe 'MemberCtrl', ->
  $scope = null
  MemberInteractionsResource = null
  interactions = [ { reaction_text: 'some reaction text' }, { reaction_text: 'some more reaction text' } ]

  beforeEach module('Actionman')

  beforeEach ->
    MemberInteractionsResource = query: jasmine.createSpy('query').andReturn(interactions)

  beforeEach inject ($rootScope, $navigate, $controller) ->
    $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }
    $scope = $rootScope.$new()
    $controller 'MemberCtrl', { $scope: $scope, MemberInteractionsResource: MemberInteractionsResource, $navigate }

  it 'should query member interactions', ->
    expect(MemberInteractionsResource.query).toHaveBeenCalled()

  it 'should set the interactions on the scope', ->
    expect($scope.interactions).toEqual(interactions)
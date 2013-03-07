describe 'ActionFormCtrl', -> 
  ActionResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach module('Actionman')

  beforeEach inject ($rootScope, $controller, $navigate) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'ActionFormCtrl', { $scope: scope, $routeParams: params, $navigate: $navigate, FormResourceService: FormResourceService, ActionResource: ActionResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 
      id: 'action'
      scope: scope
      resource: ActionResource
      params: params
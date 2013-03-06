describe 'EventFormCtrl', -> 
  EventResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach module('Actionman')

  beforeEach inject ($rootScope, $controller, $navigate) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: params, $navigate: $navigate, FormResourceService: FormResourceService, EventResource: EventResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 
      id: 'event'
      scope: scope
      resource: EventResource
      params: params
      onDeleteSuccess: jasmine.any(Function)
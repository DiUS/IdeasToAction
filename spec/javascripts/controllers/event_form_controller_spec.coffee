describe 'EventFormCtrl', -> 
  EventResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'EventFormCtrl', { $scope: scope, $routeParams: params, FormResourceService: FormResourceService, EventResource: EventResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 'event', scope, EventResource, params
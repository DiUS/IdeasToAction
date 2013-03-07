describe 'IdeaFormCtrl', -> 
  IdeaResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach module('Actionman')

  beforeEach inject ($rootScope, $controller, $navigate) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'IdeaFormCtrl', { $scope: scope, $routeParams: params, $navigate: $navigate, FormResourceService: FormResourceService, IdeaResource: IdeaResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 
      id: 'idea'
      scope: scope
      resource: IdeaResource
      params: params
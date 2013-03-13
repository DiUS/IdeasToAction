describe 'IdeaActionFormCtrl', ->
  IdeaActionResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach module('Actionman')

  beforeEach inject ($rootScope, $controller, $navigate) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'IdeaActionFormCtrl', { $scope: scope, $routeParams: params, $navigate: $navigate, FormResourceService: FormResourceService, IdeaActionResource: IdeaActionResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 
      id: 'idea_action'
      scope: scope
      resource: IdeaActionResource
      params: params
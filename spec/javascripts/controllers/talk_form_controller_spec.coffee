describe 'TalkFormCtrl', -> 
  TalkResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: params, FormResourceService: FormResourceService, TalkResource: TalkResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 'talk', scope, TalkResource, params
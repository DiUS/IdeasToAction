describe 'TalkFormCtrl', -> 
  TalkResource = {}
  FormResourceService = { bind: jasmine.createSpy('bind') }
  params = {}
  scope = null
  ctrl = null

  beforeEach module('Actionman')

  beforeEach inject ($rootScope, $controller, $navigate) ->
    scope = $rootScope.$new()
    ctrl = $controller( 'TalkFormCtrl', { $scope: scope, $routeParams: params, $navigate: $navigate, FormResourceService: FormResourceService, TalkResource: TalkResource })

  it 'should invoke form resource service to bind to the scope', ->
    expect(FormResourceService.bind).toHaveBeenCalledWith 
      id: 'talk'
      scope: scope
      resource: TalkResource
      params: params
      onDeleteSuccess: jasmine.any(Function)
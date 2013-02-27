describe 'ngExternal directive', () ->

  $compile = null
  $rootScope = null

  beforeEach(angular.mock.module('Actionman'));

  beforeEach(inject(
    ['$compile','$rootScope', ($c, $r) ->
      $compile = $c
      $rootScope = $r
    ]
  ))

  it "should navigate to the external url", () ->
    navigator.app = loadUrl: jasmine.createSpy('loadUrl')
    element = $compile('<a ng-external="http://www.google.com" href="http://www.google.com">External URL</a>')($rootScope);
    element.triggerHandler('click')
    expect(navigator.app.loadUrl).toHaveBeenCalledWith('http://www.google.com', { openExternal:true })
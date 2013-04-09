describe 'phonegapExternal', ->
  element = null
  originalOpen = null

  beforeEach module 'Actionman'

  beforeEach ->
    originalOpen = window.open
    window.open = jasmine.createSpy('open')

  afterEach ->
    window.open = originalOpen

  beforeEach inject ($rootScope, $compile) ->
    element = $compile('<a phonegap-external="http://www.mycoolexternallink.com" href="http://www.google.com">External URL</a>')($rootScope);
    
  it "should navigate to the external url", ->
    element.triggerHandler 'click'
    expect(window.open).toHaveBeenCalledWith 'http://www.mycoolexternallink.com', '_system'
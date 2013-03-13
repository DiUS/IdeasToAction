describe 'mobileFocusClick', -> 

  browserTriggerClick = (element) ->
    event = document.createEvent('MouseEvents')
    event.initMouseEvent('click')
    element[0].dispatchEvent(event)

  element = null
  originalSetTimeout = window.setTimeout;

  beforeEach module "Actionman", ->

  beforeEach inject ($rootScope, $compile) ->
    element = angular.element "<textarea mobile-focus-click></textarea>"

    scope = $rootScope
    $compile(element)(scope)
    scope.$digest()

  beforeEach -> window.setTimeout = jasmine.createSpy('setTimeout');
  afterEach -> window.setTimeout = originalSetTimeout

  it 'should delay the scrolling', ->
    browserTriggerClick element
    expect(window.setTimeout).toHaveBeenCalledWith(jasmine.any(Function), 500)
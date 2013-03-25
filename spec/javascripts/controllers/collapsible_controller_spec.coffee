describe 'CollapsibleCtrl', -> 
  scope = null
  element = $('<div class="collapsible"><div class="items"></div></div>')

  beforeEach module('Actionman')

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory) ->
    scope = $rootScope.$new()
    $controller 'CollapsibleCtrl', { $scope: scope, $element: element, dataCache: $cacheFactory('fake cache') }

    describe 'when expanding or collapsing the collapsible', () ->
      beforeEach ->
        $.fn.slideToggle = jasmine.createSpy('slideToggle').andReturn(element)
        $.fn.toggleClass = jasmine.createSpy('toggleClass').andReturn(element)
        scope.expandCollapse();

      it 'should slideToggle', inject ($compile, $rootScope) ->
        expect($.fn.slideToggle).toHaveBeenCalled();

      it 'should toggleClass', inject ($compile, $rootScope) ->
        expect($.fn.toggleClass).toHaveBeenCalled();
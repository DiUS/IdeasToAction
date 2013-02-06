describe 'ActionmanApp', ()->

  describe 'CollapsibleCtrl', () -> 
    scope = null
    ctrl = null
    element = $('<div class="collapsible"><div class="items"></div></div>')

    beforeEach inject (_$httpBackend_, $rootScope, $controller) ->
      scope = $rootScope.$new()
      ctrl = $controller( 'CollapsibleCtrl', { $scope: scope, $element: element })

    describe 'when expanding or collapsing the collapsible', () ->
      beforeEach () ->
        $.fn.slideToggle = jasmine.createSpy 'slideToggle'
        scope.expandCollapse();

      it 'should slideToggle', inject ($compile, $rootScope) ->
        expect($.fn.slideToggle).toHaveBeenCalled();
describe 'titleCount', -> 

    elm = null
    scope = null

    beforeEach module "Actionman"

    beforeEach inject ($httpBackend, $rootScope, $compile) ->
      scope = $rootScope
      scope.count = '14'
      scope.title = 'ideas'

      $httpBackend.expectGET("assets/views/tiles/count.html").
            respond("<span class='tile'><b class='featured-action-statement'>{{count}}</b><span>{{title}}</span></span>")

      elm = angular.element "<tile:count count='count' title='#{scope.title}'></tile:count>"

      $compile(elm)(scope)
      scope.$digest()
      $httpBackend.flush()

    it 'should render template', ->
      expect(elm[0].className).toContain 'tile'

    it 'should have a count', ->
      expect(elm.text()).toContain scope.count

    it 'should have a title', ->
      expect(elm.text()).toContain scope.title
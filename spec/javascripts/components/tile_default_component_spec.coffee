describe 'titleDefault', -> 

    elm = null
    scope = null

    beforeEach module "Actionman"

    beforeEach inject ($httpBackend, $rootScope, $compile) ->
      scope = $rootScope
      scope.title = 'TEDx Coolness 2013'
      scope.description = 'this rocks'

      $httpBackend.expectGET("assets/views/tiles/default.html").
            respond("<div class='tile'><h6>{{title}}</h6>{{description}}</div>")

      elm = angular.element "<tile:default title='title' description='description'></tile:default>"

      $compile(elm)(scope)
      scope.$digest()
      $httpBackend.flush()

    it 'should render template', ->
      expect(elm[0].className).toContain 'tile'

    it 'should have a title', ->
      expect(elm.text()).toContain scope.title

    it 'should have a description', ->
      expect(elm.text()).toContain scope.description
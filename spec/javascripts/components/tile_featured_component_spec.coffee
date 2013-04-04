describe 'titleFeatured', -> 

    elm = null
    scope = null

    beforeEach module "Actionman"

    beforeEach inject ($httpBackend, $rootScope, $compile) ->
      scope = $rootScope
      scope.description = 'my funky description'
      scope.heading = 'FEATURED EVENTS'
      scope.img = 'http://myimage.com/stuff.png'
      scope.title = 'TEDx Coolness 2013'

      $httpBackend.expectGET("assets/views/tiles/featured.html").
            respond("<div class='tile'><img alt='{{title}}' ng-src='{{img}}' /><strong class='featured-action-statement'>{{heading}}</strong><h5>{{title}}</h5>{{description}}</div>")

      elm = angular.element "<tile:featured description='description' heading='#{scope.heading}' img='img' title='title'></tile:featured>"

      $compile(elm)(scope)
      scope.$digest()
      $httpBackend.flush()

    it 'should render template', ->
      expect(elm[0].className).toContain 'tile'

    it 'should have a heading', ->
      expect(elm.text()).toContain scope.heading

    it 'should have a title', ->
      expect(elm.text()).toContain scope.title

    it 'should have a description', ->
      expect(elm.text()).toContain scope.description

    it 'should have an image', ->
      expect(elm.find('img').length).toEqual 1
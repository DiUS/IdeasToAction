describe 'Actionman', ()->

  describe 'collapsible', () -> 

    elm = null
    scope = null
    $httpBackend = null
    testCollection = null

    beforeEach module "Actionman", ()->

    beforeEach inject (_$httpBackend_, $rootScope, $compile) ->
      testCollection = [ { name: 'name 1'}, { name: 'name 2'} ]

      $httpBackend = _$httpBackend_
      $httpBackend.expectGET("views/collapsible/collapsible.html").
            respond("<div class='collapsible-template'>collapsible-template <span class='title'>{{title}}</span> <span class='item-template'>{{itemTemplate}}</span> <span ng-repeat='item in collection'>{{item.name}}</span></div>")

      elm = angular.element "<collapsible title='Test Items' type='testItem' collection='testCollection' item-template='template url here' />"

      scope = $rootScope
      scope.testCollection = testCollection

      $compile(elm)(scope)
      scope.$digest()

    it 'should should render the specified template', inject ($compile, $rootScope) ->
      $httpBackend.flush()
      
      expect(elm.text()).toContain("collapsible-template")

    it 'should have the title available to the template', inject ($compile, $rootScope) ->
      $httpBackend.flush()
      
      expect(elm.text()).toContain("Test Items")

    it 'should have the item-template available to the template', inject ($compile, $rootScope) ->
      $httpBackend.flush()
      
      expect(elm.text()).toContain("template url here")

    it 'should have the collection available to the template', inject ($compile, $rootScope) ->
      $httpBackend.flush()
      
      expect(elm.text()).toContain("name 1")
      expect(elm.text()).toContain("name 2")


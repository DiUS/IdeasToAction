describe 'bootstrapInput', -> 

  elm = null
  scope = null
  $httpBackend = null
  testCollection = null

  beforeEach module "Actionman", ->

  beforeEach inject (_$httpBackend_, $rootScope, $compile) ->
    testCollection = [ { name: 'name 1'}, { name: 'name 2'} ]

    $httpBackend = _$httpBackend_
    $httpBackend.expectGET("assets/views/form/bootstrap_input.html").
          respond("<div class='control-group' ng-class='{error: !!$parent.errors[key]}'>" +
                    "bootstrap_input" + 
                    "<label class='control-label' for='{{key}}'>{{description}}</label>" +
                    "<div class='controls'>" +
                      "<input id='{{key}}' placeholder='{{description}}' type='text' ng-model='modal' />" +
                      "<span class='help-inline' ng-class='{hide: !$parent.errors[key]}'>{{$parent.errors[key][0]}}</span>" +
                    "</div>" +
                  "</div>")

    elm = angular.element "<bootstrap-input key='name' description='Event Name' model='event.name'></bootstrap-input>"

    scope = $rootScope
    scope.testCollection = testCollection

    $compile(elm)(scope)
    scope.$digest()

  it 'should render the specified template', inject ($compile, $rootScope) ->
    $httpBackend.flush()
    expect(elm.text()).toContain("bootstrap_input")

  it 'should have a label', inject ($compile, $rootScope) ->
    $httpBackend.flush()
    
    expect(elm.text()).toContain("Event Name")
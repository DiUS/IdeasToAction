describe 'datepicker', () ->
  elm = null
  scope = null

  beforeEach module "Actionman"

  beforeEach inject ($rootScope, $compile) ->
    elm = angular.element("<input datepicker='datepicker' ng-model='date'>")
    scope = $rootScope
    $compile(elm)(scope)

  it 'should be able to get a date from the model', ->
    tomorrow = new Date()
    tomorrow.setDate(tomorrow.getDate() + 3)

    scope.$apply ->
      scope.date = tomorrow
    scope.$digest()
    expect(elm.datepicker().val()).toEqual(tomorrow.toString())
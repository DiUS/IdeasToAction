angular.module('Actionman').
  directive "datepicker", ->
    restrict: "A"
    require: "ngModel"
    link: (scope, element, attrs, ngModelCtrl) ->
      $ ->
        element.datepicker
          minDate: 0
          dateFormat: "dd/mm/yy"
          onSelect: (date) ->
            scope.$apply -> ngModelCtrl.$setViewValue moment(date, 'dd/mm/yyyy').startOf('day').format()

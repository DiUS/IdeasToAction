angular.module('Actionman').
  directive "datepicker", ->
    restrict: "A"
    require: "ngModel"
    link: (scope, element, attrs, ngModelCtrl) ->
      $ ->
        element.datepicker
          minDate: 0
          dateFormat: "dd/mm/yy"
          onSelect: (target_date) ->
            scope.$apply -> ngModelCtrl.$setViewValue target_date

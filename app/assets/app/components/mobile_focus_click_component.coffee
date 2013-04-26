angular.module('Actionman').
  directive 'mobileFocusClick', ->
    (scope, element, attr) ->
      return unless (/android/gi).test(navigator.appVersion)

      element.bind 'click', ->
        setTimeout ->
          element.scope().scroller.scrollElementToTop(element[0], 20, 300)
        , 1000
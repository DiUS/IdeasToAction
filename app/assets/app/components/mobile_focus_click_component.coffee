angular.module('Actionman').
  directive 'mobileFocusClick', ->
    (scope, element, attr) ->
      isAndroid = (/android/gi).test(navigator.appVersion)

      element.bind 'click', ->
        return unless isAndroid
        setTimeout ->
          element.scope().scroller.scrollElementToTop(element[0], 10, 300)
        , 1000
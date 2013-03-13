angular.module('Actionman').
  directive 'mobileFocusClick', ->
    (scope, element, attr) ->
      element.bind 'click', ->
        setTimeout ->
          $('swipe-view').scope().scroll.scrollElementToTop(element[0], 100, 200)
        , 500
angular.module('Actionman').
  directive 'mobileFocusClick', ->
    (scope, element, attr) ->
      return unless (/android/gi).test(navigator.appVersion)

      scroller = element.scope().scroller

      #
      # REFERENCE: http://stackoverflow.com/questions/8335834/how-can-i-hide-the-android-keyboard-using-javascript
      #  - create a field, focus on it then hide it
      #
      scope.hideKeyboard = ->
        field = document.createElement('input');
        field.setAttribute('type', 'text');
        $(field).css('margin-left', '-9999px');
        document.body.appendChild(field);

        setTimeout ->
            field.focus();
            setTimeout ->
                field.setAttribute('style', 'display:none;');
                setTimeout ->
                  scroller.scrollToPage(0, 200, 300)
                , 500
            , 50
        , 50

      element.bind 'click', ->
        setTimeout ->
          scroller.scrollElementToTop(element[0], 10, 300)
        , 1000

        # add click event to whole page to de-focus
        pageElement = angular.element(scroller.scroller).closest('.page')
        pageElement.bind 'click', ->
          scope.hideKeyboard()
          pageElement.unbind 'click'
        false
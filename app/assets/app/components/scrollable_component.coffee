angular.module('Actionman').
  directive 'scrollable', ->
    restrict: 'E'
    template: '<div class="scrollable-content"><div class="scroller"><div ng-transclude></div></div></div>'
    transclude: true
    replace: true
    scope: false
    link: ($scope, $element) ->
      onBeforeScrollStart = (event) ->
        event.preventDefault()
        $scope.scroller.refresh()
        false

      $scope.scroller = new iScroll $element[0], 
        hScrollbar: false 
        vScrollbar: false
        lockDirection: true
        onBeforeScrollStart: onBeforeScrollStart
angular.module('Actionman').
  directive 'scrollable', ->
    restrict: 'E'
    template: '<div class="scrollable-content"><div class="scroller"><div ng-transclude></div></div></div>'
    transclude: true
    replace: true
    scope: false
    link: ($scope, $element) ->
      onBeforeScrollStart = (event) ->
        ##
        ## NOTE: Nasty hack to prevent double clicking issue on the collapsible headers 
        ##
        event.stopPropagation() if event.target.className == 'header' || event.target.className.indexOf('title') != -1
          
        event.preventDefault()
        $scope.scroller.refresh()
        false

      $scope.scroller = new iScroll $element[0], 
        hScrollbar: false 
        vScrollbar: false
        lockDirection: true
        onBeforeScrollStart: onBeforeScrollStart
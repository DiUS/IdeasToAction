angular.module('Actionman').
  directive 'scrollable', ->
    restrict: 'E'
    template: '<div class="scrollable-content"><div class="scroller" ng-transclude></div></div>'
    transclude: true
    replace: true
    scope: false
    link: ($scope, $element) ->
      onBeforeScrollStart = (event) ->
        ##
        ## NOTE: Nasty hack to prevent double clicking issue on the collapsible headers 
        ##
        target = $(event.target)
        event.stopPropagation() if target.hasClass('content-header') || target.parents('.collapsible .content-header').length > 0
          
        event.preventDefault()
        $scope.scroller.refresh()
        false

      $scope.scroller = new iScroll $element[0], 
        hScrollbar: false 
        vScrollbar: false
        lockDirection: true
        onBeforeScrollStart: onBeforeScrollStart
#
# Based on the approach by @ccoenraets
# Demonstrated at: https://github.com/ccoenraets/mobile-ui-patterns/tree/master/page-swipe-iscroll
#
angular.module('snappy-swipe-navigate', [])

angular.module('snappy-swipe-navigate').
  controller('swipe-view-controller', ($rootScope, $scope, $element)->
    console.log("swipe-view-controller", $scope, $element)

    # The wrapperWidth before orientationChange. Used to identify the current page number in updateLayout()
    $scope.wrapperWidth = 0;

    $scope.scroll = new iScroll('pageWrapper', {
      snap: true,
      momentum: false,
      hScrollbar: false,
      vScrollbar: false,
      lockDirection: true
    })

    $scope.currentPageCount = ()->
      2

    $scope.updateLayout = (event)->
      currentPage = 0

      if ($scope.wrapperWidth > 0)
        currentPage = - Math.ceil( $('#pageScroller').position().left / $scope.wrapperWidth)

      $scope.wrapperWidth = $('#pageWrapper').width()

      $('#pageScroller').css('width', $scope.wrapperWidth * $scope.currentPageCount())
      $('.page').css('width', $scope.wrapperWidth)

      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(currentPage, 0, 0);

    $(window).bind("resize", $scope.updateLayout)
    $(window).bind("orientationchange", $scope.updateLayout)

    $scope.updateLayout()
  ).
  directive('swipeView', () ->
    return {
      restrict: 'E',
      transclude: true,
      scope: { },
      link: ($scope, $element) ->
        $scope.$parent.$watch $scope.collection_expr, (newValue, oldValue) ->
          $scope.collection = newValue || []
        $scope.$parent.$watch "#{$scope.collection_expr}.length", (newValue, oldValue) ->
          $element.find('.title sup').text(newValue);
          $scope.collection_length = newValue

      controller: 'swipe-view-controller',
      template: '<div id="pageWrapper"><div id="pageScroller"><div class="page" ><h1>Page 1</h2></div><div class="page" ><h1>Page 2</h2></div></div></div>',
      replace: true
    }
  )


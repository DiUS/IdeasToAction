#
# Based on the approach by @ccoenraets
# Demonstrated at: https://github.com/ccoenraets/mobile-ui-patterns/tree/master/page-swipe-iscroll
#
angular.module('snappy-swipe-navigate', [])

angular.module('snappy-swipe-navigate').
  service('$navigate', ($rootScope, $location)->
    @go = (path, transition)->
      console.log("$navigate.go", path, transition)
      $location.path(path)

    $rootScope.$on('$routeChangeSuccess', ($event, next, last)->
      console.log("$routeChangeSuccess. Event:", $event, "Next:", next, "Last:", last, $location.path())
      $rootScope.swipeScope.scrollToPath($location.path(), next) unless next.redirectTo
    )

  ).
  controller('swipe-view-controller', ($rootScope, $scope, $element, $location, $route, $controller, $compile)->
    $scope.onScrollEnd = ()->
      currentPage = $scope.currentPage()
      $scope.onUserScrollEnd() unless $scope.swallowNextScroll
      $scope.swallowNextScroll = false
      $scope.lastPage = $scope.currentPage()
      $scope.refreshPageHeight()
      false

    $scope.onUserScrollEnd = ()->
      currentPage = $scope.currentPage()
      if (!currentPage.is($scope.lastPage)) 
        console.log("On new page after user scroll", currentPage, $scope.lastPage)
        path = currentPage.attr('path')
        $scope.$apply("location.path('#{path}')")
      true

    $scope.element = $element
    $scope.wrapperWidth = 0
    $scope.location = $location

    $scope.scroll = new iScroll('pageWrapper', {
      snap: true,
      momentum: false,
      hScrollbar: false,
      vScrollbar: false,
      lockDirection: true,
      onScrollEnd: $scope.onScrollEnd
    })

    $scope.refreshPageHeight = ()->
      $('#pageScroller').css('height', $("> *", $scope.currentPage()).height()) 
      $scope.scroll.refresh();

    $scope.scrollToPath = (path, page)->
      indexOfPage = $scope.indexOfPageForPath(path)
      if (indexOfPage < 0)
        # Create new page
        $scope.swallowNextScroll = true
        $scope.insertPage(path, page)
        # Set index of page
        indexOfPage = $scope.indexOfPageForPath(path)
      $scope.swallowNextScroll = true
      console.log("indexOfPage", indexOfPage)
      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(indexOfPage, 0, 500);

    $scope.pageScroller = ()->
      $('#pageScroller')

    $scope.insertPage= (path, page)->
      console.log("Inserting new page for path", path)
      current = $route.current
      locals = current && current.locals

      page.element = angular.element(document.createElement("div"))
      page.element.html(locals.$template)
      page.element.addClass('page') # Always has to have page class

      page.scope = $scope.$new();
      if (current.controller)
        locals.$scope = page.scope;
        page.controller = $controller(current.controller, locals);
        page.element.contents().data('$ngControllerController', page.controller);
      
      $compile(page.element.contents())(page.scope);

      page.element.attr('path', path)

      # Clear all pages forward in history
      $scope.currentPage().next().remove() while ($scope.currentPage().next().length)

      # Add this forward page
      $scope.pageScroller().append(page.element);
      $scope.updateLayout()
      page.scope.$emit('$viewContentLoaded');
      #page.scope.$eval(attrs.onLoad);
      page.element
    

    $scope.indexOfPageForPath = (path)->
      index = -1
      $(".page", $scope.element).each (i, e)->
        index = i if $(e).attr('path') == path 
      index

    $scope.currentPageCount = ()->
      pages = $scope.pages()
      (pages && pages.length) || 0

    $scope.pages = ()->
      $('.page', $scope.element)

    $scope.currentPageIndex = ()->
      currentPage = 0

      if ($scope.wrapperWidth > 0)
        currentPage = - Math.ceil( $('#pageScroller').position().left / $scope.wrapperWidth)

      currentPage

    $scope.currentPage = ()->
      $($scope.pages()[$scope.currentPageIndex()])

    $scope.lastPage = null

    $scope.updateLayout = (event)->
      console.log "Updating layout", event
      return if $scope.currentPageCount() <= 0
      currentPage = $scope.currentPageIndex()

      $scope.wrapperWidth = $('#pageWrapper').width()

      $('#pageScroller').css('width', $scope.wrapperWidth * $scope.currentPageCount())
      $('.page').css('width', $scope.wrapperWidth)

      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(currentPage, 0, 0);
  ).
  directive('swipeView', ($rootScope, $compile, $controller, $route) ->
    return {
      restrict: 'E',
      transclude: true,
      scope: { },
      link: (scope, viewElement, attrs) ->
        $(window).bind("resize", scope.updateLayout)
        $(window).bind("orientationchange", scope.updateLayout)
        $(window).bind("ready", scope.updateLayout())
        $rootScope.swipeScope = scope

      controller: 'swipe-view-controller',
      template: '<div id="pageWrapper"><div id="pageScroller"></div></div>',
    }
  )


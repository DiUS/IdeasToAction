#
# Based on the approach by @ccoenraets
# Demonstrated at: https://github.com/ccoenraets/mobile-ui-patterns/tree/master/page-swipe-iscroll
#
angular.module('snappy-swipe-navigate', [])

angular.module('snappy-swipe-navigate').
  service('$navigate', ($rootScope, $location)->
    @go = (path, transition)->
      $location.url(path)

    self = this 

    $rootScope.$on('$routeChangeSuccess', ($event, next, last)->
      self.swipeScope.scrollToPath($location.path(), next) unless next.redirectTo
    )

  ).
  controller('swipe-view-controller', ($rootScope, $scope, $element, $location, $route, $controller, $compile)->
    $scope.disableBackButton = false
    $scope.element = $element
    $scope.wrapperWidth = 0
    $scope.location = $location
    $scope.lastPage = null

    $scope.onScrollEnd = ()->
      currentPage = $scope.currentPage()
      $scope.onUserScrollEnd() unless $scope.swallowNextScroll
      $scope.swallowNextScroll = false
      $scope.lastPage = $scope.currentPage()
      $scope.refreshPageHeight()
      false

    $scope.onPositioned = (x, y)->
      $('.follow-scroll').css({ '-webkit-transform': "translate3d(0px, #{0 - y}px, 0px)" })

    $scope.onUserScrollEnd = ()->
      currentPage = $scope.currentPage()
      if (!currentPage.is($scope.lastPage)) 
        path = currentPage.attr('path')
        $scope.$apply("location.path('#{path}')")
      true

    $scope.scroll = new iScroll('pageWrapper', {
      snap: true,
      momentum: true,
      hMomentum: false,
      hScrollbar: false,
      vScrollbar: false,
      lockDirection: true,
      onScrollEnd: $scope.onScrollEnd
      onPositioned: $scope.onPositioned
    })

    $scope.refreshPageHeight = ()->
      $('#pageScroller').css('height', $("> *", $scope.currentPage()).height()) 
      $scope.scroll.refresh();

    $scope.resetToTop = ()->
      $scope.refreshPageHeight()
      $scope.scroll.scrollToPage($scope.currentPageIndex(), 0, 300)
      true

    $scope.scrollToPath = (path, page)->
      indexOfPage = $scope.indexOfPageForPath(path)
      if (indexOfPage < 0)
        # Create new page
        $scope.swallowNextScroll = true
        $scope.insertPage(path, page)
        # Set index of page
        indexOfPage = $scope.indexOfPageForPath(path)
      $scope.scrollToPage(indexOfPage)

    $scope.scrollToPage = (indexOfPage)->
      $scope.swallowNextScroll = true
      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(indexOfPage, 0, 500);

    $scope.back = ()->
      currentPageIndex = $scope.currentPageIndex()
      if (currentPageIndex > 0)
        history.go(-1)
        true
      else
        false

    $scope.pageScroller = ()->
      $('#pageScroller')

    $scope.insertPage= (path, page)->
      current = $route.current
      locals = current && current.locals

      contentWrapper = angular.element(document.createElement("div"))
      contentWrapper.addClass('contentWrapper')
      contentWrapper.html(locals.$template)

      page.element = angular.element(document.createElement("div"))
      page.element.addClass('page') # Always has to have page class
      page.element.append(contentWrapper)

      page.scope = $scope.$new();
      if (current.controller)
        locals.$scope = page.scope;
        page.controller = $controller(current.controller, locals);
        contentWrapper.contents().data('$ngControllerController', page.controller);
      
      $compile(contentWrapper.contents())(page.scope);

      page.element.attr('path', path)

      $scope.clearAllPagesForward()
      

      # Add this forward page
      $scope.pageScroller().append(page.element);
      $scope.updateLayout()
      page.scope.$emit('$viewContentLoaded');
      #page.scope.$eval(attrs.onLoad);
      page.element
    
    $scope.clearAllPagesForward = ->
      $scope.currentPage().next().remove() while ($scope.currentPage().next().length)

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

    $scope.updateLayout = (event)->
      return if $scope.currentPageCount() <= 0
      currentPage = $scope.currentPageIndex()

      originalWidth = $scope.wrapperWidth
      $scope.wrapperWidth = $('#pageWrapper').width()

      $('#pageScroller').css('width', $scope.wrapperWidth * $scope.currentPageCount())
      $('.page').css('width', $scope.wrapperWidth)

      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(currentPage, 0, 0) if (originalWidth != $scope.wrapperWidth)
  ).
  directive('swipeView', ($rootScope, $compile, $controller, $route, $navigate) ->
    return {
      restrict: 'E',
      transclude: true,
      scope: { },
      link: (scope, viewElement, attrs) ->
        $navigate.swipeScope = scope
        $(window).bind("resize", scope.updateLayout)
        $(window).bind("orientationchange", scope.updateLayout)
        $(window).bind("ready", scope.updateLayout)
        if ((window.cordova || window.phonegap) && window.device && device.platform && device.platform.toLowerCase() == "android")
          document.addEventListener "deviceready", ()->
            document.addEventListener "backbutton", ()->
              unless (scope.disableBackButton)
                navigator.app.exitApp() unless scope.back() 

      controller: 'swipe-view-controller',
      template: '<div id="pageWrapper"><div id="pageScroller"></div></div>',
    }
  )


#
# Based on the approach by @ccoenraets
# Demonstrated at: https://github.com/ccoenraets/mobile-ui-patterns/tree/master/page-swipe-iscroll
#
angular.module('snappy-swipe-navigate', [])

angular.module('snappy-swipe-navigate').
  service('$navigate', ($rootScope, $location)->
    @go = (path, transition)->
      $location.path(path)

    self = this 

    $rootScope.$on('$routeChangeSuccess', ($event, next, last)->
      self.swipeScope.scrollToPath($location.path(), next) unless next.redirectTo
    )

  ).
  controller('swipe-view-controller', ($rootScope, $scope, $element, $location, $route, $controller, $compile)->
    updateHeader = () ->
      content = $scope.currentPage().children().children().scope().header
      $mainHeader = $('.main-header')
      $el = $('<div class="header-container">' + content + '</div>')
      $mainHeader.prepend($el)
      $mainHeader.find(".header-container:last").fadeOut 300, () -> $(@).remove()

    $scope.onScrollEnd = ()->
      currentPage = $scope.currentPage()
      $scope.onUserScrollEnd() unless $scope.swallowNextScroll
      $scope.swallowNextScroll = false
      if $scope.lastPage && $scope.lastPage[0] != $scope.currentPage()[0]
        updateHeader() 
      $scope.lastPage = $scope.currentPage()
      $scope.refreshPageHeight()
      false

    $scope.onUserScrollEnd = ()->
      currentPage = $scope.currentPage()
      if (!currentPage.is($scope.lastPage)) 
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

    $scope.resetToTop = ()->
      $scope.refreshPageHeight()
      $scope.scroll.scrollToPage($scope.currentPageIndex(), 0, 300)

    $scope.scrollToPath = (path, page)->
      indexOfPage = $scope.indexOfPageForPath(path)
      if (indexOfPage < 0)
        # Create new page
        $scope.swallowNextScroll = true
        $scope.insertPage(path, page)
        # Set index of page
        indexOfPage = $scope.indexOfPageForPath(path)
      $scope.swallowNextScroll = true
      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(indexOfPage, 0, 500);

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
      return if $scope.currentPageCount() <= 0
      currentPage = $scope.currentPageIndex()

      $scope.wrapperWidth = $('#pageWrapper').width()

      $('#pageScroller').css('width', $scope.wrapperWidth * $scope.currentPageCount())
      $('.page').css('width', $scope.wrapperWidth)

      $scope.scroll.refresh();
      $scope.scroll.scrollToPage(currentPage, 0, 0);
  ).
  directive('swipeView', ($rootScope, $compile, $controller, $route, $navigate) ->
    return {
      restrict: 'E',
      transclude: true,
      scope: { },
      link: (scope, viewElement, attrs) ->
        $(window).bind("resize", scope.updateLayout)
        $(window).bind("orientationchange", scope.updateLayout)
        $(window).bind("ready", scope.updateLayout())
        $navigate.swipeScope = scope

      controller: 'swipe-view-controller',
      template: '<div class="header main-header"><div class="header-container">Ideas into action <div class="reload pull-right" onclick="location.reload(true);"><i class="icon-refresh" /></div></div></div><div id="pageWrapper"><div id="pageScroller"></div></div>',
    }
  )


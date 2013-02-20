window.CollapsibleCtrl = ($scope, $element, $navigate) -> 
    $scope.expandCollapse = () -> 
      $element.toggleClass('collapsed').toggleClass('expanded')
      $element.find('.items').slideToggle 300, () ->
        $navigate.swipeScope.refreshPageHeight();
        console.log "Element offset", $element.offset().left, $element.offset().top
        $navigate.swipeScope.scroll.scrollToElement($element[0], 300)

    $scope.title = $element.attr('title')
    $scope.collection_expr = $element.attr('collection')
    $scope.itemTemplate = $element.attr('item-template')
    $scope.startAs = $element.attr('start-as') || 'collapsed'

    $scope.expandCollapse() if 'expanded' == $scope.startAs

window.CollapsibleCtrl = ($scope, $element) -> 
    $scope.expandCollapse = () -> 
      $element.toggleClass('collapsed').toggleClass('expanded')
      $element.find('.items').slideToggle 300, () ->
        $('body').animate { scrollTop: $element.offset().top, 300 }

    $scope.title = $element.attr('title')
    $scope.collection_expr = $element.attr('collection')
    $scope.itemTemplate = $element.attr('item-template')
    $scope.startAs = $element.attr('start-as') || 'collapsed'

    $scope.expandCollapse() if 'expanded' == $scope.startAs

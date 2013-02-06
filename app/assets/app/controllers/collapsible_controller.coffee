window.CollapsibleCtrl = ($scope, $element) -> 
    $scope.expandCollapse = () -> 
      $element.find('.items').slideToggle 300

    $scope.title = $element.attr('title')
    $scope.collection_expr = $element.attr('collection')
    $scope.itemTemplate = $element.attr('item-template')

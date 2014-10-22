window.CollapsibleCtrl = ($scope, $element) ->
    $scope.$on 'actionCreated', -> $scope.expanded = true

    $scope.expandCollapse = -> 
      return if $scope.canCollapse == false || $scope.collection.length == 0

      $element.toggleClass('collapsed').toggleClass('expanded')
      $element.find('.items').slideToggle 300, ->
        $scope.scroller.refresh()
        $scope.scroller.scrollToElement($element[0], 300, 0)

    $scope.title = $element.attr('title')
    $scope.collection_expr = $element.attr('collection')
    $scope.itemTemplate = $element.attr('item-template')
    $scope.expanded = !!$element.attr('expanded')
    if $element.attr('can-collapse') == "false"
      $scope.canCollapse = false
    else
      $scope.canCollapse = true

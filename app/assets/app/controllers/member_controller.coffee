window.MemberCtrl = ($scope, $http, $routeParams) ->
  $http.get("#{window.ENDPOINT}/member.json").success (data) -> 
    $scope.member = data
    $http.get("#{window.ENDPOINT}/member/reactions.json").success (data) -> 
      $scope.member.reactions = data
    $http.get("#{window.ENDPOINT}/member/actions.json").success (data) -> 
      $scope.member.actions = data
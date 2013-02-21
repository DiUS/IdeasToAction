window.MemberCtrl = ($scope, $http, $routeParams, dataCache) ->
  $http.get("#{window.ENDPOINT}/member.json", { cache: dataCache }).success (data) -> 
    $scope.member = data
    $http.get("#{window.ENDPOINT}/member/reactions.json", { cache: dataCache }).success (data) -> 
      $scope.member.reactions = data
      $http.get("#{window.ENDPOINT}/member/actions.json", { cache: dataCache }).success (data) -> 
        $scope.member.actions = data
        $('.loading').removeClass('loading')
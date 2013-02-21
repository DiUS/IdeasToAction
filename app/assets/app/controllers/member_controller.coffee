window.MemberCtrl = ($scope, $http, $routeParams, dataCache) ->

  $scope.header = 'My profile <a class="home-page pull-right" href="#/home"><i class="icon-home" /></a>'

  $http.get("#{window.ENDPOINT}/member.json", { cache: dataCache }).success (data) -> 
    $scope.member = data
    $http.get("#{window.ENDPOINT}/member/reactions.json", { cache: dataCache }).success (data) -> 
      $scope.member.reactions = data
      $http.get("#{window.ENDPOINT}/member/actions.json", { cache: dataCache }).success (data) -> 
        $scope.member.actions = data
        $('.loading').removeClass('loading')
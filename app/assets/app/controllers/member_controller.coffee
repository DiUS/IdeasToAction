window.MemberCtrl = ($scope, $http, MemberIdeaActionsResource, MemberSession, MemberResource) ->
  $scope.memberSession = MemberSession
  $scope.emailChangeError = null
  $scope.emailChangeSuccess = false

  $scope.updateEmail = ->
    MemberResource.update({id: $scope.memberSession.id, email: $scope.memberSession.email},
      ->
        window.localStorage.setItem "TEDXLoginEmail", $scope.memberSession.email
        $scope.emailChangeError = null
        $scope.emailChangeSuccess = true
      (e) ->
        $scope.emailChangeSuccess = false
        if e.data?.errors?.email[0]?
          $scope.emailChangeError = e.data.errors.email[0]
        else
          $scope.emailChangeError = 'unknown error'
    )

  $scope.idea_actions = MemberIdeaActionsResource.query ->
    $('.loading').removeClass('loading')

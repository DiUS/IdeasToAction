window.MemberCtrl = ($scope, $http, MemberIdeaActionsResource, MemberSession, MemberResource) ->
  $scope.memberSession = MemberSession
  $scope.emailChangeError = null
  $scope.emailChangeSuccess = false

  $scope.updateEmail = ->
    MemberResource.update({memberId: $scope.memberSession.id, email: $scope.memberSession.email},
      ->
        window.localStorage.setItem "TEDXLoginEmail", $scope.memberSession.email
        $scope.emailChangeError = null
        $scope.emailChangeSuccess = true
      (error_data) ->
        $scope.emailChangeSuccess = false
        if error_data.data?.errors?.email[0]?
          $scope.emailChangeError = error_data.data.errors.email[0]
        else
          $scope.emailChangeError = 'unknown error'
    )

  $scope.idea_actions = MemberIdeaActionsResource.query ->
    $('.loading').removeClass('loading')

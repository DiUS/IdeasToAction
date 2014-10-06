angular.module('Actionman', [ 'snappy-swipe-navigate', 'ui', 'ngResource' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', -> 
        scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")
        false
  ).
  factory('dataCache', ($cacheFactory)->
    $cacheFactory('Actionman Cache')
  ).
  factory("errorsInterceptor", ($q, $location) ->
    (promise) ->
      promise.then ((response) ->
        response
      ), (response) ->
        if response.status == 401
          $location.path("/unauthorised")
        else if response.status == 500
          $location.path("/internal_server_error")
        $q.reject response
  ).
  config(($routeProvider, $httpProvider) ->
      $httpProvider.responseInterceptors.push('errorsInterceptor')

      $routeProvider.
        when('/config',                           { templateUrl: 'assets/views/admin/config.html',       controller: ConfigCtrl }).
        when('/home',                             { templateUrl: 'assets/views/home/index.html',         controller: HomeCtrl }).

        # Events
        when('/events',                           { templateUrl: 'assets/views/events/events.html',      controller: EventsCtrl }).
        when('/events/:eventId',                  { templateUrl: 'assets/views/events/event.html',       controller: EventCtrl }).

        # Talks
        when('/talks',                            { templateUrl: 'assets/views/talks/talks.html',        controller: TalksCtrl }).
        when('/events/:eventId/talks/:talkId',    { templateUrl: 'assets/views/talks/talk.html',         controller: TalkCtrl }).

        # Ideas
        when('/ideas',                            { templateUrl: 'assets/views/ideas/ideas.html',        controller: IdeasCtrl }).
        when('/ideas/:ideaId',                    { templateUrl: 'assets/views/ideas/idea.html',         controller: IdeaCtrl }).

        # Actions
        when('/actions',                          { templateUrl: 'assets/views/actions/actions.html',    controller: IdeaActionsCtrl }).
        
        when('/member',                           { templateUrl: 'assets/views/members/member.html',     controller: MemberCtrl }).
        when('/found',                            { templateUrl: 'assets/views/found/index.html',        controller: FoundCtrl }).
        when('/login',                            { templateUrl: 'assets/views/login/login.html',        controller: LoginCtrl }).
        when('/unauthorised',                     { templateUrl: 'assets/views/errors/unauthorized.html',controller: ErrorsCtrl }).
        when('/internal_server_error',            { templateUrl: 'assets/views/errors/internal_server_error.html',controller: ErrorsCtrl }).
        otherwise( {redirectTo: '/home'} )
  ).
  run ($location, $rootScope, $http) ->
    $rootScope.$on "$routeChangeStart", () ->
      if not $rootScope.member or not $rootScope.member.email
        $http.get("#{window.ENDPOINT}/member_sessions/check.json").success (data) ->
          if data.admin_authenticated
            $rootScope.member = data
          else
            $location.path "/login"

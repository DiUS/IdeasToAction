angular.module('Actionman', [ 'snappy-swipe-navigate', 'ui', 'ngResource' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', () -> 
        # scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")
        false
  ).
  directive('ngExternal', () ->
    (scope, elm, attrs) -> 
      elm.bind 'click', () -> 
        if navigator.app?
          navigator.app.loadUrl(attrs.ngExternal, { openExternal:true }) 
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
  config ($routeProvider, $httpProvider) ->
      $httpProvider.responseInterceptors.push('errorsInterceptor')

      $routeProvider.
        when('/config',                           { templateUrl: 'assets/views/admin/config.html',       controller: ConfigCtrl }).
        when('/home',                             { templateUrl: 'assets/views/home/index.html',         controller: HomeCtrl }).
        when('/talks-events',                     { templateUrl: 'assets/views/talks-events/index.html', controller: TalksEventsCtrl }).

        # Events
        when('/events/:eventId',                  { templateUrl: 'assets/views/events/event.html',       controller: EventCtrl }).

        # Talks
        when('/events/:eventId/talks',              { templateUrl: 'assets/views/talks/talks.html',        controller: TalksCtrl }).
        when('/events/:eventId/talks/:talkId',      { templateUrl: 'assets/views/talks/talk.html',         controller: TalkCtrl }).

        # Ideas
        when('/ideas/:ideaId',                    { templateUrl: 'assets/views/ideas/idea.html',         controller: IdeaCtrl }).

        when('/member',                           { templateUrl: 'assets/views/members/member.html',     controller: MemberCtrl }).
        when('/found',                            { templateUrl: 'assets/views/found/index.html',        controller: FoundCtrl }).
        when('/login',                            { templateUrl: 'assets/views/auth/login.html',         controller: AuthCtrl }).
        when('/unauthorised',                     { templateUrl: 'assets/views/errors/unauthorized.html',controller: ErrorsCtrl }).
        when('/internal_server_error',            { templateUrl: 'assets/views/errors/internal_server_error.html',controller: ErrorsCtrl }).
        otherwise( {redirectTo: '/home'} )
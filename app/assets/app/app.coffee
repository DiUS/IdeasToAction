window.ajaxCounter = 0

angular.module('Actionman', [ 'snappy-swipe-navigate', 'ui', 'ngResource' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', () -> 
        scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")
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
  factory('ajaxCounterInterceptor', ($q, $window) ->
    (promise) ->
      promise.then (response) ->
        window.ajaxCounter--
        response
      , (response) ->
        window.ajaxCounter--
        $q.reject(response)
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
  config [ '$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
      $httpProvider.responseInterceptors.push('ajaxCounterInterceptor')
      $httpProvider.responseInterceptors.push('errorsInterceptor')
      $httpProvider.defaults.transformRequest.push (data, headersGetter) ->
        window.ajaxCounter++
        data

      $routeProvider.
        when('/config',                           { templateUrl: 'assets/views/admin/config.html',       controller: ConfigCtrl }).
        when('/home',                             { templateUrl: 'assets/views/home/index.html',         controller: HomeCtrl }).

        # Events
        when('/events/new',                       { templateUrl: 'assets/views/events/form.html',        controller: EventFormCtrl }).
        when('/events/edit',                      { templateUrl: 'assets/views/events/edit.html',        controller: EventsEditCtrl }).
        when('/events/edit/:eventId',             { templateUrl: 'assets/views/events/form.html',        controller: EventFormCtrl }).
        when('/events/:eventId',                  { templateUrl: 'assets/views/events/event.html',       controller: EventCtrl }).

        # Talks
        when('/events/:eventId/talks/new',          { templateUrl: 'assets/views/talks/form.html',         controller: TalkFormCtrl }).
        when('/events/:eventId/talks/edit/:talkId', { templateUrl: 'assets/views/talks/form.html',         controller: TalkFormCtrl }).
        when('/events/:eventId/talks',              { templateUrl: 'assets/views/talks/talks.html',        controller: TalksCtrl }).
        when('/events/:eventId/talks/:talkId',      { templateUrl: 'assets/views/talks/talk.html',         controller: TalkCtrl }).

        when('/ideas/:ideaId',                    { templateUrl: 'assets/views/ideas/idea.html',         controller: IdeaCtrl }).
        when('/member',                           { templateUrl: 'assets/views/members/member.html',     controller: MemberCtrl }).
        when('/talks-events',                     { templateUrl: 'assets/views/talks-events/index.html', controller: TalksEventsCtrl }).
        when('/search',                           { templateUrl: 'assets/views/search/index.html',       controller: SearchCtrl }).
        when('/search/:query_text',               { templateUrl: 'assets/views/search/index.html',       controller: SearchCtrl }).
        when('/login',                            { templateUrl: 'assets/views/auth/login.html',         controller: AuthCtrl }).
        when('/unauthorised',                     { templateUrl: 'assets/views/errors/unauthorized.html',controller: ErrorsCtrl }).
        when('/internal_server_error',            { templateUrl: 'assets/views/errors/internal_server_error.html',controller: ErrorsCtrl }).
        otherwise( {redirectTo: '/home'} )
    ]

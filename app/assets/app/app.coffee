angular.module('Actionman', [ 'mobile-navigate', 'ui' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', () -> 
        scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")

      scope.$on '$pageTransitionSuccess', () ->
        setTimeout () ->
          $('.mb-page').css('position', 'static')
        , 800
  ).
  config [ '$routeProvider', ($routeProvider) ->
    $routeProvider.
      when('/config',                           { templateUrl: 'views/admin/config.html',       controller: ConfigCtrl }).
      when('/home',                             { templateUrl: 'views/home/index.html',         controller: HomeCtrl }).
      when('/events/:eventId',                  { templateUrl: 'views/events/event.html',       controller: EventCtrl }).
      when('/events/:eventId/talks',            { templateUrl: 'views/talks/talks.html',        controller: TalksCtrl }).
      when('/events/:eventId/talks/:talkId',    { templateUrl: 'views/talks/talk.html',         controller: TalkCtrl }).
      when('/ideas/:ideaId',                    { templateUrl: 'views/ideas/idea.html',         controller: IdeaCtrl }).
      when('/member',                           { templateUrl: 'views/members/member.html',     controller: MemberCtrl }).
      when('/talks-events',                     { templateUrl: 'views/talks-events/index.html', controller: TalksEventsCtrl }).
      otherwise({redirectTo: '/home'})
    ]

angular.module('Actionman', [ 'mobile-navigate' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', () -> 
        scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")
  ).
  config [ '$routeProvider', ($routeProvider) ->
    $routeProvider.
      when('/config',                        { templateUrl: 'views/admin/config.html',   controller: ConfigCtrl }).
      when('/home',                          { templateUrl: 'views/home/index.html',     controller: HomeCtrl }).
      when('/events/:eventId',               { templateUrl: 'views/events/event.html',   controller: EventCtrl }).
      when('/events/:eventId/talks',         { templateUrl: 'views/talks/talks.html',    controller: TalksCtrl }).
      when('/events/:eventId/talks/:talkId', { templateUrl: 'views/talks/talk.html',     controller: TalkCtrl }).
      when('/ideas/new',                     { templateUrl: 'views/ideas/new.html',      controller: IdeaEditCtrl }).
      when('/ideas/new/inspiredByTalk/:talkId',        { templateUrl: 'views/ideas/new.html',      controller: IdeaEditCtrl }).
      when('/ideas/:ideaId',                 { templateUrl: 'views/ideas/idea.html',     controller: IdeaCtrl }).
      when('/member',                        { templateUrl: 'views/members/member.html', controller: MemberCtrl }).
      otherwise({redirectTo: '/events/1'})
    ]

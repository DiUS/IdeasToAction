angular.module('Actionman', [ 'mobile-navigate' ]).
  directive('ngTap', ()->
    (scope, elm, attrs) -> 
      elm.bind 'click', () -> 
        scope.$apply(attrs.ngTap)
  ).
  config [ '$routeProvider', ($routeProvider) ->
      $routeProvider.
          when('/talks',  { templateUrl: 'views/talks/talks.html', controller: TalksCtrl }).
          when('/talks/:talkId',  { templateUrl: 'views/talks/talk.html', controller: TalkCtrl }).
          otherwise({redirectTo: '/talks'})
    ]

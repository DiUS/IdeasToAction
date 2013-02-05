angular.module('Actionman', [ 'mobile-navigate' ]).
  directive('ngHref', ($navigate)->
    (scope, elm, attrs) -> 
      scope.navigate = $navigate
      elm.bind 'click', () -> 
        scope.$apply("navigate.go('#{attrs.ngHref}', 'slide')")
  ).
  config [ '$routeProvider', ($routeProvider) ->
      $routeProvider.
          when('/config',  { templateUrl: 'views/admin/config.html', controller: ConfigCtrl }).
          when('/talks',  { templateUrl: 'views/talks/talks.html', controller: TalksCtrl }).
          when('/talks/:talkId',  { templateUrl: 'views/talks/talk.html', controller: TalkCtrl }).
          when('/ideas/:ideaId',  { templateUrl: 'views/ideas/idea.html', controller: IdeaCtrl }).
          otherwise({redirectTo: '/talks'})
    ]

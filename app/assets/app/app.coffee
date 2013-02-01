angular.module('Actionman', []).
  config [ '$routeProvider', ($routeProvider) ->
      $routeProvider.
          when('/talks',  { templateUrl: 'templates/talks.html', controller: null }).
          when('/talks/:talkId',  { templateUrl: 'views/talks/talk.html', controller: TalkCtrl }).
          otherwise({redirectTo: '/talks/1'})
    ]
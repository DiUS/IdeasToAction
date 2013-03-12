angular.module('Actionman').factory('FeaturedResource', ($resource) ->
  $resource(
    '/featured', 
    { }, # no params
    query: {
      method: 'GET', isArray: false
    }
  )
)
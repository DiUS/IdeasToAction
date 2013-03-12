angular.module('Actionman').factory('FeaturedResource', ($resource) ->
  $resource(
    "#{window.ENDPOINT}/featured",
    { }, # no params
    query: {
      method: 'GET', isArray: false
    }
  )
)
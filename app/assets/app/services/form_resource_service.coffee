angular.module('Actionman').service 'FormResourceService', ->
  @bind = (id, scope, Resource, params) ->
    scope[id] = new Resource

    success = (response) -> 
      scope.errors = null
      scope[id] = response || null

    error = (response) -> 
      scope.errors = response.data.errors

    scope[id].$get params, success, error if params[id + 'Id']

    scope.create = -> scope[id].$save success, error
    scope.update = -> scope[id].$update params, success, error
    scope.delete = -> scope[id].$delete params, success, error
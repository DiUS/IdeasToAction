angular.module('Actionman').service 'FormResourceService', ->
  @bind = (options) ->
    
    id = options.id
    scope = options.scope
    Resource = options.resource
    params = options.params
    onDeleteSuccess = options.onDeleteSuccess

    scope[id] = new Resource

    success = (response) -> 
      scope.errors = null
      scope[id] = response || null

    deleteSuccess = (response) =>
      success response
      onDeleteSuccess(response)

    error = (response) -> 
      scope.errors = response.data.errors

    scope[id].$get params, success, error if params[id + 'Id']

    scope.create = -> scope[id].$save success, error
    scope.update = -> scope[id].$update params, success, error
    scope.delete = -> scope[id].$delete params, deleteSuccess, error
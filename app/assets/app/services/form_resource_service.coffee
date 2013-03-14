angular.module('Actionman').service 'FormResourceService', ($timeout) ->
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

    deleteSuccess = (response) ->
      success response
      onDeleteSuccess(response)

    updateSuccess = (response) ->
      success response
      scope.updated = true
      $timeout ->
        scope.updated = false
      , 4000

    error = (response) -> 
      scope.errors = response.data.errors

    scope[id].$get params, success, error if params[id + 'Id']

    scope.create = -> scope[id].$save params, success, error
    scope.update = -> scope[id].$update params, updateSuccess, error
    scope.delete = -> scope[id].$delete params, deleteSuccess, error
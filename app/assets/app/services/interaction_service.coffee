angular.module('Actionman').service 'Interaction', (InteractionResource) ->
  interaction = null

  new: -> interaction = new InteractionResource
  resource: -> interaction
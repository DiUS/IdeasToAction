angular.module('Actionman').
  service "MemberSession", ->
    @create = (errorMsg, id, email, loggedIn) ->
      @errorMsg = errorMsg
      @id = id
      @email = email
      @loggedIn = loggedIn
      @

    this
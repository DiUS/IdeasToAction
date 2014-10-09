angular.module('Actionman').
  filter "unique", ->
    (collection, keyname) ->
      output = []
      keys = []
      angular.forEach collection, (item) ->
        key = item[keyname]
        if keys.indexOf(key) is -1
          keys.push key
          output.push item
      output

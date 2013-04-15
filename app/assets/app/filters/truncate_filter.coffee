angular.module('Actionman').
  filter 'truncate', ->
    (text, length) ->
      end = "..."
      text = '' unless text?
      length = 10 unless length?

      if text.length <= length || text.length - end.length <= length
        return text;
      else
        return text.substring(0, length-end.length) + end;
$ ->
  $('form').submit (e) ->
    unless confirm 'are you sure?'
      e.preventDefault()



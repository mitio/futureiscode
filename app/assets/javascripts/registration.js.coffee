# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#municipality_id', (evt) ->
    $.ajax 'update_towns',
      type: 'GET'
      dataType: 'script'
      data: {
        municipality_id: $("#municipality_id option:selected").val()
      }

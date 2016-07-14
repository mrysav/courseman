# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    $('#add_university').hide()
            
    $('#add_university_link').click (e) ->
        $('#get_university').hide(400)
        $('#university_id').val('')
        $('#add_university').show(400)
        
$(document).on('turbolinks:load', ready);
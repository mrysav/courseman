# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    $('#add_university').hide()
    $('#get_location').hide()
    $('#add_location').hide()
    
    $('#review_course_attributes_university_attributes_id').change (e) ->            
        if $('#review_course_attributes_university_attributes_id').val() != ''
            $('#get_location').show()       
            $.ajax '/locations',
              type: 'GET'
              dataType: 'script'
              data: {
                university_id: $("#review_course_attributes_university_attributes_id option:selected").val()
              }
              error: (jqXHR, textStatus, errorThrown) ->
                console.log("AJAX Error: #{textStatus}")
              success: (data, textStatus, jqXHR) ->
                console.log("Dynamic country select OK!")
                
        else
            $('#get_location').hide(400)
            
    $('#add_university_link').click (e) ->
        $('#get_university').hide(400)
        $('#get_location').hide(400)
        $('#add_university').show(400)
        $('#add_location').show(400)
    
    $('#add_location_link').click (e) ->
        $('#get_location').hide(400)
        $('#add_location').show(400)
        
$(document).ready(ready)
$(document).on('page:load', ready)
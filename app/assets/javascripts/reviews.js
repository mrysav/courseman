//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

function toggleUniversityInfo() {
    var dropdown = document.getElementById("university_id");
    if (dropdown.value == '0' && dropdown.value != '') {
        document.getElementById('university_info').style.visibility = 'visible';
    }
    else {
        document.getElementById('university_info').style.visibility = 'hidden';
    }
}

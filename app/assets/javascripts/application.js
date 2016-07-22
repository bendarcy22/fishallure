// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });
var marker;
var map;
var clicked = false;
function initMap() {
  var myLatLng = {lat: 42.3601, lng: -71.0589};
  map = new google.maps.Map(document.getElementById('map'), {
    center: myLatLng,
    zoom: 12
  });
  google.maps.event.addListener(map, 'click', function(event) {
    if(clicked === false){
      addMarker(event.latLng, map);
      clicked = true;
    }
  });
}
function addMarker(location, map) {
  marker = new google.maps.Marker({
    position: location,
    map: map,
    draggable: true,
    animation: google.maps.Animation.DROP
  });
}
function getCatchLocation() {
  var lat = marker.getPosition().lat();
  var lng = marker.getPosition().lng();
}
$('#add-catch').on('click', getCatchLocation);
google.maps.event.addDomListener(window, 'load', initialize);

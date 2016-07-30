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
//= require map/index
//= require map/new
//= require map/edit

$(function(){ $(document).foundation(); });

var map;
function drawMap() {
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmVuZGFyY3kiLCJhIjoiY2lxeHYzenMzMDFsdGZ4a3FuczZkOGRyZyJ9.VUJFQ0bsqkMTHHBa9X2DEg';
  map = L.mapbox.map('map', 'mapbox.streets-satellite', { zoomControl: false });
  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);
  var $geolocate = $('#locate-me');
  map.fitBounds([
    [41.346397049733966, -70.1029577255249],
    [43.369451896762385, -72.04429244995117]
    ]);
  if (!navigator.geolocation) {
    $geolocate.val('Geolocation is not available');
  } else {
    $geolocate.on('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      map.locate();
    });
  }
  map.on('locationfound', function(e) {
    map.fitBounds(e.bounds);
  });

  map.on('locationerror', function() {
    alert('Not found, please enter your location manually');
  });
}

var fishIcon = L.icon({
    iconUrl: '/assets/rising-trout-5a92ef818cf821a4f024db2aad423cc8e6a851e5e69cd16a687b66fd0e667d18.png',
    iconSize: [40, 40],
    popupAnchor: [0, -20],
});

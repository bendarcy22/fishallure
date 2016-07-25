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

function drawShowCatchMap(catchLat, catchLng){
  drawMap();
  marker = L.marker(new L.LatLng(catchLat, catchLng), {
    draggable: true
  });
  marker.addTo(map);
}

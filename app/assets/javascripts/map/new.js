function drawNewCatchMap(){
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmVuZGFyY3kiLCJhIjoiY2lxeHYzenMzMDFsdGZ4a3FuczZkOGRyZyJ9.VUJFQ0bsqkMTHHBa9X2DEg';

  var map = L.mapbox.map('map', 'mapbox.streets-satellite', { zoomControl: false });
  new L.Control.Zoom({ position: 'bottomright' }).addTo(map);
  var marker = L.marker(new L.LatLng(42.3603, -71.0580), {
    draggable: true
  });
  var $latForm = $('#catch_latitude');
  var $lngForm = $('#catch_longitude');
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
    marker.setLatLng(e.latlng).update();
    ondragend();
  });

  map.on('locationerror', function() {
    alert('Not found, please enter your location manually');
  });

  function ondragend() {
    var m = marker.getLatLng();
    $latForm.val(marker.getLatLng().lat);
    $lngForm.val(marker.getLatLng().lng);
  }

  function moveMarkerPopulateLatLong(err, data) {
    var lat = data.latlng[0];
    var lng = data.latlng[1];
    $latForm.val(lat);
    $lngForm.val(lng);

    marker.setLatLng(data.latlng).update();
    map.panTo(data.latlng);
  }

  marker.addTo(map);
  marker.on('dragend', ondragend);
  ondragend();
}

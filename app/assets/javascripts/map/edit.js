var map;
var marker;
var $latForm = $('#catch_latitude');
var $lngForm = $('#catch_longitude');


function drawEditCatchMap(catchLat, catchLng){
  drawMap();
  marker = L.marker(new L.LatLng(catchLat, catchLng), {
    icon: fishIcon,
    draggable: true
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

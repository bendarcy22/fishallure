var map;

function drawShowCatchMap(catchLat, catchLng){
  drawMap();
  marker = L.marker(new L.LatLng(catchLat, catchLng), {
    icon: fishIcon
  });
  map.setView(new L.LatLng(catchLat, catchLng), 10);
  marker.addTo(map);
}

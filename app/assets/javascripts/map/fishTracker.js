var map;
function drawFishTrackerMap(id){
  drawMap();
  var id = $('#fish_id').data('id');
  var marker;
  var arrayMarkers = [];
  var request = $.ajax({
    method: "GET",
    url: "/api/fish_types/" + id
  });
  request.done(function(data) {
    data.catches.forEach(function(c){
      marker = L.marker(new L.LatLng(c.latitude, c.longitude), { icon: fishIcon }).addTo(map)
      .bindPopup("<a href=/catches/" + c.id + ">" + c.caught_at + "</a>")
      .openPopup();
      arrayMarkers.push(marker);
    });
    var group = new L.featureGroup(arrayMarkers);
    map.fitBounds(group.getBounds());
  });
}

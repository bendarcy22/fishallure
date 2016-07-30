var map;

function drawIndexCatchMap(){
  drawMap();
  var marker;
  var arrayMarkers = [];
  var request = $.ajax({
    method: "GET",
    url: "/api/catches"
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
function drawPersonalCatchMap(){
  drawMap();
  var marker;
  var arrayMarkers = [];
  var request = $.ajax({
    method: "GET",
    url: "/api/catches/personal"
  });
  request.done(function(data) {
    if(data.catches.length > 0){
    data.catches.forEach(function(c){
      marker = L.marker(new L.LatLng(c.latitude, c.longitude), { icon: fishIcon }).addTo(map)
      .bindPopup("<a href=/catches/" + c.id + ">" + c.caught_at + "</a>")
      .openPopup();
      arrayMarkers.push(marker);
    });
    var group = new L.featureGroup(arrayMarkers);
    map.fitBounds(group.getBounds());
  }
  });
}

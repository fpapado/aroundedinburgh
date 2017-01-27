let Map = {
    placeMap: null,
    geoLayer: null,

    init(mapId, centerLatLng, zoomLevel) {
        this.placeMap = L.map(mapId).setView(centerLatLng, zoomLevel);

        // L.tileLayer('https://api.mapbox.com/styles/v1/fpapado/civo3gxei00472joilop02agr/tiles/256/{z}/{x}/{y}?access_token={accessToken}', {
        L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/light-v8/tiles/256/{z}/{x}/{y}?access_token={accessToken}', {
            attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
            maxZoom: 18,
            id: 'your.mapbox.project.id',
            accessToken: 'pk.eyJ1IjoiZnBhcGFkbyIsImEiOiJjaXZudmtvbXQwMDBjMnp0ZWR6NjE4ZTFhIn0.s4SzhiEbl9tkhkkTBmSzjA',
        }).addTo(this.placeMap);

        this.geoLayer = L.geoJSON(null, {
            onEachFeature: function (feature, layer) {
              layer.bindPopup(feature.properties.popupContent,
                  {className: 'pop'});
            }
          }).addTo(this.placeMap);
    },

    addMarker(placeTitle, latlng) {
        let placemarker = L.marker(latlng).addTo(this.placeMap);
        placemarker
            .bindPopup(placeTitle, {className: 'pop'})
            .openPopup();
    },

    addFeature(placeGeo) {
        let coords = placeGeo.geometry.coordinates;
        if (coords[0] === 0 && coords[1] === 0) {
            // 0, 0 is our fallback if something goes wrong in back-end
            console.log('It seems we have no coordinates for this place.');
        }
        else {
            this.geoLayer.addData(placeGeo);
        }
    },
};

export default Map;

import icons from './icons';

let Map = {
    placeMap: null,
    geoLayer: null,

    init(mapId, centerLatLng, zoomLevel) {
        this.placeMap = L.map(mapId).setView(centerLatLng, zoomLevel);

        // L.tileLayer('https://api.mapbox.com/styles/v1/fpapado/civo3gxei00472joilop02agr/tiles/256/{z}/{x}/{y}?access_token={accessToken}', {
        L.tileLayer('https://stamen-tiles.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}.png', {
            attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by <a href="http://openstreetmap.org">OpenStreetMap</a>, under <a href="http://www.openstreetmap.org/copyright">ODbL</a>.',
            maxZoom: 18
        }).addTo(this.placeMap);

        // Configure GeoJSON layer
        this.geoLayer = L.geoJSON(null, {
            pointToLayer: function (feature, latlng) {
              let category = feature.properties.category;
              return L.marker(latlng, {icon: icons[category]});
            },
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

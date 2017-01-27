// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files in vendor, which are never wrapped in imports and therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import 'phoenix_html';
import Map from './map';

var Turbolinks = require("turbolinks")
let singleMap = document.getElementById('placemap');
let allPlacesMap = document.getElementById('allplaces');
let defaultViewLatLng = [55.9533, -3.1883];

if(allPlacesMap) {
    initMap(allPlacesMap, defaultViewLatLng);

    let request = new XMLHttpRequest();
    request.open('GET', '/api/places', true);

    request.onload = function() {
      if (this.status >= 200 && this.status < 400) {
        // Success!
        let places = JSON.parse(this.response);

        for (let place of places) {
          let placegeo = JSON.parse(place.attributes.placejson)
          console.log(placegeo);
          Map.addFeature(placegeo);
        }
        console.log(Map.geoLayer);
      } else {
        // We reached the server, but it returned an error
        console.log("Sorry, we could not get the list of places")
      }
    };

    request.onerror = function() {
      // There was a connection error of some kind
      console.log("There was an error connecting to the server")
    };

    request.send();
}
else if(singleMap) {
    let placeGeo = JSON.parse(singleMap.getAttribute('data-placejson'));
    let coords = placeGeo.geometry.coordinates;

    // GeoJSON is lng, lat; we flip them
    initMap(singleMap, [coords[1], coords[0]]);
    Map.addFeature(placeGeo);
}

function initMap(map, center) {
    if (center[0] === 0 && center[1] === 0) {
        console.log('No geocoding data. Showing default city view.');
        Map.init(map.id, defaultViewLatLng);
    }
    else {
        Map.init(map.id, center);
    }
}

Turbolinks.start()

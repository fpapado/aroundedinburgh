// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import 'phoenix_html';
import Map from './map';

let map = document.getElementById('placemap');
let defaultViewLatLng = [55.9533, -3.1883];

if(map) {
    let placeGeo = JSON.parse(map.getAttribute('data-placejson'));
    let coords = placeGeo.geometry.coordinates;

    // GeoJSON is lng, lat; we flip them
    initMap([coords[1], coords[0]]);
    Map.addFeature(placeGeo);
}

function initMap(center) {
    if (center[0] === 0 && center[1] === 0) {
        console.log('No geocoding data. Showing default city view.');
        Map.init(map.id, defaultViewLatLng);
    }
    else {
        Map.init(map.id, center);
    }
}

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

if(map) {
    L.mapbox.accessToken = 'pk.eyJ1IjoiZnBhcGFkbyIsImEiOiJjaXZudmtvbXQwMDBjMnp0ZWR6NjE4ZTFhIn0.s4SzhiEbl9tkhkkTBmSzjA';
    let geocoder = L.mapbox.geocoder('mapbox.places');

    let address = map.getAttribute('data-address');
    geocoder.query(address, initMap);
}

function initMap(err, data) {
    if (err) {
        console.log('No geocoding data. Showing default view');
        Map.init(map.id, [55.9533, -3.1883]);
    }
    else {
        Map.init(map.id, data.latlng);
        Map.addMarker(map.getAttribute('data-name'), data.latlng);
    }
}

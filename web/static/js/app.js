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
// import Map from './map';

let placemap = L.map('mapid').setView([55.942456, -3.182448], 14);

// L.tileLayer('https://api.mapbox.com/styles/v1/fpapado/civo3gxei00472joilop02agr/tiles/256/{z}/{x}/{y}?access_token={accessToken}', {
L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/light-v8/tiles/256/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'your.mapbox.project.id',
    accessToken: 'pk.eyJ1IjoiZnBhcGFkbyIsImEiOiJjaXZudmtvbXQwMDBjMnp0ZWR6NjE4ZTFhIn0.s4SzhiEbl9tkhkkTBmSzjA',
}).addTo(placemap);

let placemarker = L.marker([55.942456, -3.182448]).addTo(placemap)
placemarker.bindPopup('Filament Coffee', {className: 'pop'}).openPopup();

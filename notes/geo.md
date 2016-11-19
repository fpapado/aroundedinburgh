DONE Add popup back in for place markers

DONE Center Map on Place feature

DONE When adding data from geocoding to DB, flip them around.
    The reason for this is that mapping frameworks use lat-lon, but spatial
    databases use lon-lat. Our mapping framework uses GeoJSON, which prescribes
    lon-lat as well, so there's no need to save them flipped!

Liberate the data:
    DONE Add geo library
    DONE Install PostGIS
    DONE Migrate to add address, coordinates fields

    DONE Client-side geocoding call to mapbox from address

    DONE
    This is a compromise for now, but I plan to liberate the data
    using OpenStreetMap geocoding and a server implementation.
    Besides, it doesn't make sense to be sending a JS bundle plus
    the calls every time the user wants the location on a map.
    Having the location server-side would also help with distance
    calculations.

    DONE
    When adding a place:
        User fills Address field, sent to server
        Address is geocoded
          cast to coordinates as %Point.Geo
        Address, coordinates are saved into DB

    DONE Add function to cast %Geo.Point into GeoJSON
    DONE Add function to cast %Rumbl.Place into a GeoJSON Feature
    DONE Add GeoJSON feature to view
    DONE Remove Mapbox API, and
      DONE Decode GeoJSON and add feature to leaflet in javascript

defmodule Rumbl.GeoHelpers do
    alias Rumbl.Place

    def geocode_to_point({:ok, %{lat: lat, lon: lng}}) do
        %Geo.Point{coordinates: {lat, lng}, srid: nil}
    end

    def flip_point_coordinates(%Geo.Point{} = point) do
        # Used to flip lat, lng in geocoded points
        {lat, lng} = point.coordinates
        %{point | coordinates: {lng, lat}}
    end

    def place_to_geojson_feature(%Place{} = place) do
        %{"type": "Feature",
            "geometry": point_to_geojson(place.coordinates),
            "properties": %{"name": place.title,
                            "popupContent": place.title,
                           },
        }
        |> Poison.encode!()
    end

    def point_to_geojson(%Geo.Point{} = point) do
        point
        |> Geo.JSON.encode()
    end

    def point_to_geojson(nil) do
        # If point is nil (either old entry or geocoding error)
        # Then return a GeoJSON point with coordinates 0, 0
        # The front-end should then handle this case
        %Geo.Point{}
        |> Geo.JSON.encode()
    end
end

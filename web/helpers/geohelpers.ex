defmodule Rumbl.GeoHelpers do
    def geocode_to_point({:ok, %{lat: lat, lon: lng}}) do
        %Geo.Point{ coordinates: {lat, lng}, srid: nil}
    end
end

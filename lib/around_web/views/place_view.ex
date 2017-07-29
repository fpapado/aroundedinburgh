defmodule AroundWeb.PlaceView do
  use AroundWeb, :view
  alias AroundWeb.Place

  # Helpers
  def category_as_colour(%Place{category_id: category_id}) do
      case category_id do
          1 -> 'bright-green'
          2 -> 'pale-red'
          3 -> 'light-blue'
          4 -> 'dark-red'
          5 -> 'gold'
          _ -> 'gray'
      end
  end

  def category_name_or_blank(%Place{category: category}) do
      case category do
          nil -> 'Uncategorised'
          _   -> category.name
      end
  end

  def username_or_blank(%Place{user: user}) do
      case user do
          nil -> 'Guest User'
          _   -> user.name
      end
  end

  def address_or_blank(%Place{address: address}) do
      case address do
          nil -> 'Unspecified Address'
          _   -> address
      end
  end

  # JSON Data for API
  def render("index.json", %{data: places}) do
      Enum.map(places, fn place ->
        render("place.json", %{data: place})
      end)
  end

  def render("show.json", %{data: place}) do
      %{data: render_one(place, AroundWeb.PlaceView, "place.json")}
  end

  # Render single place in JSONAPI format
  def render("place.json", %{data: place}) do
      %{
          "type": "place",
          "id": place.id,
          "attributes": %{
              "name": place.title,
              "address": address_or_blank(place),
              "category": category_name_or_blank(place),
              "placejson": AroundWeb.GeoHelpers.place_to_geojson_feature(place)
          }
      }
  end
end

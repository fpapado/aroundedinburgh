defmodule Rumbl.PlaceView do
  use Rumbl.Web, :view
  alias Rumbl.Place

  def category_as_colour(%Place{category_id: category_id}) do
      case category_id do
          1 -> 'bright-green'
          2 -> 'pale-red'
          3 -> 'light-blue'
          4 -> 'dark-red'
          5 -> 'gold'
          _ -> 'gold'
      end
  end
end

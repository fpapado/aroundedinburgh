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
          nil -> 'Unknown'
          _   -> user.name
      end
  end
end

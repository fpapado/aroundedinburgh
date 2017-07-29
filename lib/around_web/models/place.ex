defmodule AroundWeb.Place do
  use AroundWeb, :model
  alias AroundWeb.GeoHelpers

  schema "places" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :address, :string
    field :coordinates, Geo.Point
    belongs_to :user, AroundWeb.User
    belongs_to :category, AroundWeb.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:category)
  end

  def coordinates_changeset(model, params \\ %{}) do
      model
      |> changeset(params)
      |> cast(params, ~w(address), [])
      |> put_coordinates_from_address()
  end

    defp put_coordinates_from_address(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{address: address}} ->
                address
                |> Geocoder.call()
                |> GeoHelpers.geocode_to_point()
                |> GeoHelpers.flip_point_coordinates()
                |> (fn point -> put_change(changeset, :coordinates, point) end).()

            _ ->
                changeset
          end
    end
end

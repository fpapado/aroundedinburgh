defmodule Rumbl.Place do
  use Rumbl.Web, :model

  schema "places" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :address, :string
    field :coordinates, Geo.Point
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(url title description address)
  @optional_fields ~w(category_id)
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:category)
  end
end

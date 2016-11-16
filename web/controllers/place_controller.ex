defmodule Rumbl.PlaceController do
  use Rumbl.Web, :controller
  plug :scrub_params, "place" when action in [:create, :update]

  alias Rumbl.Place

  def index(conn, _params) do
    places = Repo.all(Place)
    render(conn, "index.html", places: places)
  end

  def new(conn, _params) do
    changeset = Place.changeset(%Place{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"place" => place_params}) do
    changeset = Place.changeset(%Place{}, place_params)

    case Repo.insert(changeset) do
      {:ok, _place} ->
        conn
        |> put_flash(:info, "Place created successfully.")
        |> redirect(to: place_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    place = Repo.get!(Place, id)
    render(conn, "show.html", place: place)
  end

  def edit(conn, %{"id" => id}) do
    place = Repo.get!(Place, id)
    changeset = Place.changeset(place)
    render(conn, "edit.html", place: place, changeset: changeset)
  end

  def update(conn, %{"id" => id, "place" => place_params}) do
    place = Repo.get!(Place, id)
    changeset = Place.changeset(place, place_params)

    case Repo.update(changeset) do
      {:ok, place} ->
        conn
        |> put_flash(:info, "Place updated successfully.")
        |> redirect(to: place_path(conn, :show, place))
      {:error, changeset} ->
        render(conn, "edit.html", place: place, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    place = Repo.get!(Place, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(place)

    conn
    |> put_flash(:info, "Place deleted successfully.")
    |> redirect(to: place_path(conn, :index))
  end
end

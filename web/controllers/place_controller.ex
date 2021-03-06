defmodule Rumbl.PlaceController do
  use Rumbl.Web, :controller
  alias Rumbl.Place
  alias Rumbl.Category

  plug :scrub_params, "place" when action in [:create, :update]
  plug :load_categories when action in [:new, :create, :edit, :update]

  def user_places(user) do
      assoc(user, :places)
  end

  def place_categories(place) do
      assoc(place, :categories)
  end

  defp load_categories(conn, _) do
      query =
          Category
          |> Category.alphabetical
          |> Category.names_and_ids
      categories = Repo.all query
      assign(conn, :categories, categories)
  end

  def action(conn, _) do
    try do
      apply(__MODULE__, action_name(conn),
            [conn, conn.params, conn.assigns.current_user])
    rescue
        e in KeyError ->
          apply(__MODULE__, action_name(conn),
                [conn, conn.params])
    end
  end

  def index(conn, _params, user) do
    places =
        Place
        |> Repo.all
        |> Repo.preload([:category])

    render(conn, "index.html", places: places)
  end

  def index_json(conn, _params) do
    places =
      Place
      |> Repo.all
      |> Repo.preload([:category])

    render(conn, "index.json", data: places)
  end

  def user_places_index(conn, _params, user) do
      places = Repo.all(user_places(user))
      |> Repo.preload([:user, :category])

      render(conn, "index_manage.html", places: places)
  end

  def new(conn, _params, user) do
    changeset =
        user
        |> build_assoc(:places)
        |> Place.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"place" => place_params}, user) do
    changeset =
        user
        |> build_assoc(:places)
        |> Place.coordinates_changeset(place_params)

    case Repo.insert(changeset) do
      {:ok, _place} ->
        conn
        |> put_flash(:info, "Place created successfully.")
        |> redirect(to: place_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    place =
        Repo.get!(Place, id)
        |> Repo.preload([:user, :category])
    #place = Repo.get!(user_places(user), id)

    render(conn, "show.html", place: place)
  end

  def edit(conn, %{"id" => id}, user) do
    #place = Repo.get!(Place, id)
    place = Repo.get!(user_places(user), id)
    changeset = Place.coordinates_changeset(place)

    render(conn, "edit.html", place: place, changeset: changeset)
  end

  def update(conn, %{"id" => id, "place" => place_params}, user) do
    # place = Repo.get!(Place, id)
    place = Repo.get!(user_places(user), id)
    changeset = Place.coordinates_changeset(place, place_params)

    case Repo.update(changeset) do
      {:ok, place} ->
        conn
        |> put_flash(:info, "Place updated successfully.")
        |> redirect(to: place_path(conn, :show, place))
      {:error, changeset} ->
        render(conn, "edit.html", place: place, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    #place = Repo.get!(Place, id)
    place = Repo.get!(user_places(user), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(place)

    conn
    |> put_flash(:info, "Place deleted successfully.")
    |> redirect(to: place_path(conn, :index))
  end
end

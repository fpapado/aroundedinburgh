defmodule AroundWeb.PlaceControllerTest do
  use AroundWeb.ConnCase

  alias AroundWeb.Place
  @valid_attrs %{description: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, place_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing places"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, place_path(conn, :new)
    assert html_response(conn, 200) =~ "New place"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, place_path(conn, :create), place: @valid_attrs
    assert redirected_to(conn) == place_path(conn, :index)
    assert Repo.get_by(Place, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, place_path(conn, :create), place: @invalid_attrs
    assert html_response(conn, 200) =~ "New place"
  end

  test "shows chosen resource", %{conn: conn} do
    place = Repo.insert! %Place{}
    conn = get conn, place_path(conn, :show, place)
    assert html_response(conn, 200) =~ "Show place"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, place_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    place = Repo.insert! %Place{}
    conn = get conn, place_path(conn, :edit, place)
    assert html_response(conn, 200) =~ "Edit place"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    place = Repo.insert! %Place{}
    conn = put conn, place_path(conn, :update, place), place: @valid_attrs
    assert redirected_to(conn) == place_path(conn, :show, place)
    assert Repo.get_by(Place, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    place = Repo.insert! %Place{}
    conn = put conn, place_path(conn, :update, place), place: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit place"
  end

  test "deletes chosen resource", %{conn: conn} do
    place = Repo.insert! %Place{}
    conn = delete conn, place_path(conn, :delete, place)
    assert redirected_to(conn) == place_path(conn, :index)
    refute Repo.get(Place, place.id)
  end
end

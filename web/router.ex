defmodule Rumbl.Router do
  use Rumbl.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Rumbl.Auth, repo: Rumbl.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Rumbl do
    pipe_through :browser # Use the default browser stack

    get "/", PlaceController, :index
    get "/about", PageController, :index
    resources "/places", PlaceController, only: [:index, :show]

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", Rumbl do
      pipe_through [:browser, :authenticate_user]

      # Only show the user's places in manage
      get "/places", PlaceController, :user_places_index

      # All the actions except the default index. Show goes to the usual action
      resources "/places", PlaceController, only: [:show, :new, :create, :edit, :update, :delete]
  end

  scope "/api", Rumbl do
    pipe_through :api

    get "/places", PlaceController, :index_json, as: :index
  end
end

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

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/places", PlaceController, only: [:index, :show]
  end

  scope "/manage", Rumbl do
      pipe_through [:browser, :authenticate_user]

      # Only show the user's places in manage
      get "/places", PlaceController, :user_places_index

      # All the actions except the default index. Show goes to the usual action
      resources "/places", PlaceController, only: [:show, :new, :create, :edit, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rumbl do
  #   pipe_through :api
  # end
end

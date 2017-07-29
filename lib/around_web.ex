defmodule AroundWeb do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use AroundWeb, :controller
      use AroundWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: AroundWeb

      alias Around.Repo
      import Ecto
      import Ecto.Query

      import AroundWeb.Router.Helpers
      import AroundWeb.Gettext
      import AroundWeb.Auth, only: [authenticate_user: 2]   # Make authenticate_user available to all controllers
    end
  end

  def view do
    quote do
    use Phoenix.View, root: "lib/around_web/templates",
                      namespace: AroundWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import AroundWeb.Router.Helpers
      import AroundWeb.ErrorHelpers
      import AroundWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import AroundWeb.Auth, only: [authenticate_user: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Around.Repo
      import Ecto
      import Ecto.Query
      import AroundWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

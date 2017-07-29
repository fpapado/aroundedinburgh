defmodule AroundWeb.UserController do
	use AroundWeb, :controller

	alias Around.Accounts
	alias Around.Accounts.User

	alias AroundWeb.Auth

	plug :authenticate_user when action in [:index, :show]

	def index(conn, _params) do
		users = Accounts.list_users()
		render(conn, "index.html", users: users)
	end

	def show(conn, %{"id" => id}) do
		user = Accounts.get_user!(id)
		render(conn, "show.html", user: user)
	end

	def new(conn, _params) do
		# changeset = User.changeset(%User{})
		changeset = Accounts.change_user(%User{})
		render(conn, "new.html", changeset: changeset)
	end

	def create(conn, %{"user" => user_params}) do
		# changeset = User.registration_changeset(%User{}, user_params)
		case Accounts.create_user(user_params) do
			{:ok, user} ->
				conn
				|> Auth.login(user)
				|> put_flash(:info, "#{user.name} created!")
				|> redirect(to: user_path(conn, :index))
			{:error, changeset} ->
				render(conn, "new.html", changeset: changeset)
		end
	end
end

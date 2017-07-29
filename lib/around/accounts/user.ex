defmodule Around.Accounts.User do
	use Ecto.Schema
	import Ecto.Changeset
	alias Around.Accounts.User
	alias Comeonin.Bcrypt

	schema "users" do
		field :name, :string
		field :username, :string
		field :password, :string, virtual: true
		field :password_hash, :string
		has_many :places, AroundWeb.Place

		timestamps()
	end

	@doc false
	def changeset(%User{} = user, attrs) do
		user
		|> cast(attrs, [:name, :username])
		|> validate_required([:name, :username])
		|> validate_length(:username, min: 4, max: 20)
		|> unique_constraint(:username)
	end

	@doc false
	def registration_changeset(changeset, attrs) do
		changeset
		|> cast(attrs, ~w(password), [])
		|> validate_length(:password, min: 6, max: 100)
		|> put_pass_hash()
	end

	defp put_pass_hash(changeset) do
		case changeset do
			%Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
				put_change(changeset, :password_hash, Bcrypt.hashpwsalt(pass))

			_ ->
				changeset
		end
	end
end

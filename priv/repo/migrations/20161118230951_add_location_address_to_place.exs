defmodule Rumbl.Repo.Migrations.AddLocationAddressToPlace do
  use Ecto.Migration

  def change do
      alter table(:places) do
          add :address, :string
          add :coordinates, :geometry
      end
  end
end

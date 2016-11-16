defmodule Rumbl.Repo.Migrations.AddCategoryIdToVideo do
  use Ecto.Migration

  def change do
      alter table(:places) do
          add :category_id, references(:categories)
      end
  end
end

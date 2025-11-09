defmodule EngramAPI.Repo.Migrations.AddCollectionsTable do
  use Ecto.Migration

  def change do
    create table("collections") do
      add :name,    :string, size: 120
      add :description,    :string, size: 120
      add :icon, :string, size: 120

      timestamps()
    end
  end
end

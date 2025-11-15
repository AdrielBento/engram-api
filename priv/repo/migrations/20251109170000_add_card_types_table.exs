defmodule EngramAPI.Repo.Migrations.AddCardTypesTable do
  use Ecto.Migration

  def change do
    create table(:card_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :text, null: false
      add :slug, :string, null: false
      add :deleted_at, :naive_datetime

      timestamps()
    end

    create unique_index(:card_types, [:slug])
  end
end

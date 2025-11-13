defmodule EngramAPI.Repo.Migrations.AddDecksTable do
  use Ecto.Migration

  def change do
    create table("decks") do
      add :name, :string, size: 120
      add :description, :string, size: 120
      add :icon, :string, size: 120
      add :deleted_at, :naive_datetime, null: true, default: nil
      add :collection_id, references(:collections, type: :binary_id, on_delete: :nothing)

      timestamps()
    end
  end
end

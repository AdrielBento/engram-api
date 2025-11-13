defmodule EngramAPI.Repo.Migrations.AddCardsTable do
  use Ecto.Migration

  def change do
    create table("cards") do
      add :question, :string, size: 255
      add :answer, :string, size: 255
      add :state, :string, size: 20, null: false, default: "learning"
      add :step, :integer, null: false, default: 0
      add :stability, :float
      add :difficulty, :float
      add :scheduled_days, :integer
      add :due, :utc_datetime, null: false
      add :last_review, :utc_datetime
      add :deleted_at, :naive_datetime, null: true, default: nil
      add :deck_id, references(:decks, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:cards, [:deck_id])
  end
end

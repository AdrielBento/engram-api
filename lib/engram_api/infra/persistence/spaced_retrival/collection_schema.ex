defmodule EngramAPI.Infrastructure.Persistence.SpacedRetrival.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :name, :string
    field :description, :string
    field :icon, :string
    field :deleted_at, :naive_datetime, default: nil

    has_many :decks, EngramAPI.Infrastructure.Persistence.SpacedRetrival.Deck

    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [
      :name,
      :description,
      :icon
    ])
    |> validate_required([:name, :description, :icon])
  end
end

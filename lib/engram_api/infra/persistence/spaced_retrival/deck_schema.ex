defmodule EngramAPI.Infrastructure.Persistence.SpacedRetrival.Deck do
  use Ecto.Schema
  import Ecto.Changeset
  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.{Collection, Card}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "decks" do
    field :description, :string
    field :name, :string
    field :icon, :string
    field :deleted_at, :naive_datetime, default: nil

    belongs_to :collection, Collection
    has_many :cards, Card

    timestamps()
  end

  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [
      :name,
      :description,
      :icon,
      :collection_id
    ])
    |> validate_required([:name, :description, :icon, :collection_id])
    |> foreign_key_constraint(:collection_id)
  end
end

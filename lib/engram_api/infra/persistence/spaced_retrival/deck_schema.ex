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

    belongs_to :collection, Collection
    has_many :cards, Card

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

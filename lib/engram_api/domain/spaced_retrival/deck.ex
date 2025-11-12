defmodule EngramAPI.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "decks" do
    field :description, :string
    field :name, :string
    field :icon, :string

    belongs_to :collection, EngramAPI.Collections.Collection
    has_many :cards, EngramAPI.Cards.Card

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

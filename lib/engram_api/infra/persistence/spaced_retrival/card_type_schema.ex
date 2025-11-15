defmodule EngramAPI.Infrastructure.Persistence.SpacedRetrival.CardType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "card_types" do
    field :name, :string
    field :description, :string
    field :slug, :string
    field :deleted_at, :naive_datetime, default: nil

    timestamps()
  end

  def changeset(card_type, attrs) do
    card_type
    |> cast(attrs, [
      :name,
      :description,
      :slug
    ])
    |> validate_required([:name, :description, :slug])
    |> unique_constraint(:slug)
  end
end

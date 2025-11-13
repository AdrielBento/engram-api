defmodule EngramApi.Infra.Repositories.DeckRepository do
  alias EngramAPI.Domain.SpacedRetrival.Deck

  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Deck,
    as: DeckSchema

  alias EngramAPI.Repo

  @spec save(Deck.t()) :: {:ok, Deck.t()} | {:error, any()}
  def save(%Deck{} = deck) do
    changeset = DeckSchema.changeset(%DeckSchema{}, to_persistence(deck))

    case Repo.insert!(changeset) do
      %DeckSchema{} = schema -> to_domain(schema)
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp to_domain(%DeckSchema{} = schema) do
    Deck.new(%{
      id: schema.id,
      name: schema.name,
      description: schema.description,
      icon: schema.icon,
      collection_id: schema.collection_id,
      inserted_at: schema.inserted_at,
      updated_at: schema.updated_at,
      deleted_at: schema.deleted_at
    })
  end

  defp to_persistence(%Deck{} = deck) do
    %{
      id: deck.id,
      name: deck.name,
      description: deck.description,
      icon: deck.icon,
      collection_id: deck.collection_id
    }
  end
end

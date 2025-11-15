defmodule EngramApi.Infra.Repositories.CardTypeRepository do
  alias EngramAPI.Domain.SpacedRetrival.CardType

  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.CardType,
    as: CardTypeSchema

  alias EngramAPI.Repo

  @spec save(CardType.t()) :: {:ok, CardType.t()} | {:error, any()}
  def save(%CardType{} = card_type) do
    changeset = CardTypeSchema.changeset(%CardTypeSchema{}, to_persistence(card_type))

    case Repo.insert!(changeset) do
      %CardTypeSchema{} = schema -> to_domain(schema)
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp to_domain(%CardTypeSchema{} = schema) do
    CardType.new(%{
      id: schema.id,
      name: schema.name,
      description: schema.description,
      slug: schema.slug,
      inserted_at: schema.inserted_at,
      updated_at: schema.updated_at,
      deleted_at: schema.deleted_at
    })
  end

  defp to_persistence(%CardType{} = card_type) do
    %{
      id: card_type.id,
      name: card_type.name,
      description: card_type.description,
      slug: card_type.slug
    }
  end
end

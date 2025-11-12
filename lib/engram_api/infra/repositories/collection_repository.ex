defmodule EngramApi.Infra.Repositories.CollectionRepository do
  alias EngramAPI.Domain.SpacedRetrival.Collection

  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Collection,
    as: CollectionSchema

  alias EngramAPI.Repo

  @spec save(Collection.t()) :: {:ok, Collection.t()} | {:error, any()}
  def save(%Collection{} = collection) do
    changeset = CollectionSchema.changeset(%CollectionSchema{}, to_persistence(collection))

    case Repo.insert!(changeset) do
      %CollectionSchema{} = schema -> to_domain(schema)
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp to_domain(%CollectionSchema{} = schema) do
    Collection.new(%{
      id: schema.id,
      description: schema.description,
      icon: schema.icon,
      name: schema.name
    })
  end

  defp to_persistence(%Collection{} = collection) do
    %{
      id: collection.id,
      description: collection.description,
      name: collection.name,
      icon: collection.icon
    }
  end
end

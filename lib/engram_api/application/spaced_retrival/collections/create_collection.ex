defmodule EngramAPI.Application.SpacedRetrival.Collections.Create do
  alias EngramAPI.Domain.SpacedRetrival.Collection

  alias EngramApi.Infra.Repositories.CollectionRepository

  @spec call(map()) :: {:ok, Collection.t()} | {:error, any()}
  def call(attrs) do
    with {:ok, collection} <- Collection.new(attrs),
         {:ok, collection} <- CollectionRepository.save(collection) do
      {:ok, collection}
    else
      error -> error
    end
  end
end

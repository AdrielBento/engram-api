defmodule EngramAPI.Application.SpacedRetrival.CardTypes.Create do
  alias EngramAPI.Domain.SpacedRetrival.CardType

  alias EngramApi.Infra.Repositories.CardTypeRepository

  @spec call(map()) :: {:ok, CardType.t()} | {:error, any()}
  def call(attrs) do
    with {:ok, card_type} <- CardType.new(attrs),
         {:ok, card_type} <- CardTypeRepository.save(card_type) do
      {:ok, card_type}
    else
      error -> error
    end
  end
end

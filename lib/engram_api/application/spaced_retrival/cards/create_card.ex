defmodule EngramAPI.Application.SpacedRetrival.Cards.Create do
  alias EngramAPI.Domain.SpacedRetrival.Card

  alias EngramApi.Infra.Repositories.CardRepository

  @spec call(map()) :: {:ok, Card.t()} | {:error, any()}
  def call(attrs) do
    with {:ok, card} <- Card.new(attrs),
         {:ok, card} <- CardRepository.save(card) do
      {:ok, card}
    else
      error -> error
    end
  end
end

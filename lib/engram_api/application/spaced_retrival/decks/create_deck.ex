defmodule EngramAPI.Application.SpacedRetrival.Decks.Create do
  alias EngramAPI.Domain.SpacedRetrival.Deck

  alias EngramApi.Infra.Repositories.DeckRepository

  @spec call(map()) :: {:ok, Deck.t()} | {:error, any()}
  def call(attrs) do
    with {:ok, deck} <- Deck.new(attrs),
         {:ok, deck} <- DeckRepository.save(deck) do
      {:ok, deck}
    else
      error -> error
    end
  end
end

defmodule EngramApi.Infra.Repositories.CardRepository do
  alias EngramAPI.Domain.SpacedRetrival.Card

  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Card,
    as: CardSchema

  alias EngramAPI.Repo

  @spec save(Card.t()) :: {:ok, Card.t()} | {:error, any()}
  def save(%Card{} = card) do
    changeset = CardSchema.changeset(%CardSchema{}, to_persistence(card))

    case Repo.insert!(changeset) do
      %CardSchema{} = schema -> to_domain(schema)
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp to_domain(%CardSchema{} = schema) do
    Card.new(%{
      id: schema.id,
      question: schema.question,
      answer: schema.answer,
      deck_id: schema.deck_id,
      state: schema.state,
      step: schema.step,
      stability: schema.stability,
      difficulty: schema.difficulty,
      scheduled_days: schema.scheduled_days,
      due: schema.due,
      last_review: schema.last_review,
      inserted_at: schema.inserted_at,
      updated_at: schema.updated_at,
      deleted_at: schema.deleted_at
    })
  end

  defp to_persistence(%Card{} = card) do
    %{
      id: card.id,
      question: card.question,
      answer: card.answer,
      deck_id: card.deck_id,
      state: card.state,
      step: card.step,
      stability: card.stability,
      difficulty: card.difficulty,
      scheduled_days: card.scheduled_days,
      due: card.due,
      last_review: card.last_review
    }
  end
end

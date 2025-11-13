defmodule EngramAPIWeb.SpacedRetrival.Cards.CardController do
  use EngramAPIWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias EngramAPIWeb.SpacedRetrival.Cards.Dto.{
    CreateCardParams,
    CreateCardResponse
  }

  alias EngramAPI.Application.SpacedRetrival.Cards.Create
  alias EngramAPI.Domain.SpacedRetrival.Card

  plug OpenApiSpex.Plug.CastAndValidate,
    json_render_error_v2: true

  tags ["cards"]

  operation :create,
    summary: "Create card",
    description: "Create a new card for spaced retrieval",
    request_body: {"Card params", "application/json", CreateCardParams},
    responses: %{
      201 => {"Card", "application/json", CreateCardResponse},
      422 => OpenApiSpex.JsonErrorResponse.response()
    }

  def create(conn, _params) do
    card_params = Map.get(conn, :body_params)

    with {:ok, %Card{} = card} <- Create.call(card_params) do
      conn
      |> put_status(:created)
      |> json(%{
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
        last_review: card.last_review,
        inserted_at: card.inserted_at,
        updated_at: card.updated_at
      })
    end
  end
end

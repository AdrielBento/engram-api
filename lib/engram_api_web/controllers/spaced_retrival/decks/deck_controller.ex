defmodule EngramAPIWeb.SpacedRetrival.Decks.DeckController do
  use EngramAPIWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias EngramAPIWeb.SpacedRetrival.Decks.Dto.{
    CreateDeckParams,
    CreateDeckResponse
  }

  alias EngramAPI.Application.SpacedRetrival.Decks.Create
  alias EngramAPI.Domain.SpacedRetrival.Deck

  plug OpenApiSpex.Plug.CastAndValidate,
    json_render_error_v2: true

  tags ["decks"]

  operation :create,
    summary: "Create deck",
    description: "Create a new deck for spaced retrieval",
    request_body: {"Deck params", "application/json", CreateDeckParams},
    responses: %{
      201 => {"Deck", "application/json", CreateDeckResponse},
      422 => OpenApiSpex.JsonErrorResponse.response()
    }

  def create(conn, _params) do
    deck_params = Map.get(conn, :body_params)

    with {:ok, %Deck{} = deck} <- Create.call(deck_params) do
      conn
      |> put_status(:created)
      |> json(%{
        id: deck.id,
        name: deck.name,
        description: deck.description,
        icon: deck.icon,
        collection_id: deck.collection_id,
        inserted_at: deck.inserted_at,
        updated_at: deck.updated_at
      })
    end
  end
end

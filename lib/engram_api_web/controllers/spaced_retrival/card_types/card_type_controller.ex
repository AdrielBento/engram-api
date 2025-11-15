defmodule EngramAPIWeb.SpacedRetrival.CardTypes.CardTypeController do
  use EngramAPIWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias EngramAPIWeb.SpacedRetrival.CardTypes.Dto.{
    CreateCardTypeParams,
    CreateCardTypeResponse
  }

  alias EngramAPI.Application.SpacedRetrival.CardTypes.Create
  alias EngramAPI.Domain.SpacedRetrival.CardType

  plug OpenApiSpex.Plug.CastAndValidate,
    json_render_error_v2: true

  tags ["card_types"]

  operation :create,
    summary: "Create card type",
    description: "Create a new card type for spaced retrieval",
    request_body: {"Card type params", "application/json", CreateCardTypeParams},
    responses: %{
      201 => {"Card type", "application/json", CreateCardTypeResponse},
      422 => OpenApiSpex.JsonErrorResponse.response()
    }

  def create(conn, _params) do
    card_type_params = Map.get(conn, :body_params)

    with {:ok, %CardType{} = card_type} <- Create.call(card_type_params) do
      conn
      |> put_status(:created)
      |> json(%{
        id: card_type.id,
        name: card_type.name,
        description: card_type.description,
        slug: card_type.slug,
        inserted_at: card_type.inserted_at,
        updated_at: card_type.updated_at
      })
    end
  end
end

defmodule EngramAPIWeb.SpacedRetrival.Collections.CollectionController do
  use EngramAPIWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias EngramAPIWeb.SpacedRetrival.Collections.Schema.{
    CreateCollectionResponse,
    CreateCollectionParams
  }

  alias EngramAPI.Application.SpacedRetrival.Collections.Create
  alias EngramAPI.Domain.SpacedRetrival.Collection

  plug OpenApiSpex.Plug.CastAndValidate,
    json_render_error_v2: true

  tags ["collections"]

  operation :create,
    summary: "Create collection",
    description: "Create a new collection for spaced retrieval",
    request_body: {"Collection params", "application/json", CreateCollectionParams},
    responses: %{
      201 => {"Collection", "application/json", CreateCollectionResponse},
      422 => OpenApiSpex.JsonErrorResponse.response()
    }

  def create(conn, _params) do
    collection_params = Map.get(conn, :body_params)

    with {:ok, %Collection{} = collection} <- Create.call(collection_params) do
      conn
      |> put_status(:created)
      |> json(%{
        id: collection.id,
        name: collection.name,
        description: collection.description,
        icon: collection.icon,
        inserted_at: collection.inserted_at,
        updated_at: collection.updated_at
      })
    end
  end
end

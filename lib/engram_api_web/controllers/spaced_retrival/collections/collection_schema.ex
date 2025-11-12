defmodule EngramAPIWeb.SpacedRetrival.Collections.Schema do
  alias OpenApiSpex.Schema

  defmodule CreateCollectionParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCollectionParams",
      description: "Params to create a collection",
      type: :object,
      properties: %{
        name: %Schema{
          type: :string,
          description: "Collection name",
          pattern: ~r/[a-zA-Z][a-zA-Z0-9_]+/
        },
        description: %Schema{
          type: :string,
          description: "Collection description",
          format: :string
        },
        icon: %Schema{type: :string, description: "Collection Icon", format: :string}
      },
      required: [:name, :description, :icon],
      example: %{
        "name" => "Biology",
        "description" => "Biology notes",
        "icon" => "📚"
      }
    })
  end

  defmodule CreateCollectionResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCollectionResponse",
      description: "Response schema for creating a collection",
      type: :object,
      properties: %{data: CreateCollectionParams},
      example: %{
        "id" => "550e8400-e29b-41d4-a716-446655440000",
        "name" => "Biology",
        "description" => "Biology notes",
        "icon" => "📚",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end
end

defmodule EngramAPIWeb.SpacedRetrival.Decks.Dto do
  alias OpenApiSpex.Schema

  defmodule CreateDeckParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateDeckParams",
      description: "Params to create a deck",
      type: :object,
      properties: %{
        name: %Schema{
          type: :string,
          description: "Deck name",
          pattern: ~r/[a-zA-Z][a-zA-Z0-9_]+/
        },
        description: %Schema{
          type: :string,
          description: "Deck description",
          format: :string
        },
        icon: %Schema{type: :string, description: "Deck Icon", format: :string},
        collection_id: %Schema{
          type: :string,
          description: "Identifier of the collection this deck belongs to",
          format: :uuid
        }
      },
      required: [:name, :description, :icon, :collection_id],
      example: %{
        "name" => "BiologyDeck",
        "description" => "Deck for biology cards",
        "icon" => "🃏",
        "collection_id" => "550e8400-e29b-41d4-a716-446655440000"
      }
    })
  end

  defmodule CreateDeckResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateDeckResponse",
      description: "Response schema for creating a deck",
      type: :object,
      properties: %{data: CreateDeckParams},
      example: %{
        "id" => "550e8400-e29b-41d4-a716-446655440000",
        "name" => "BiologyDeck",
        "description" => "Deck for biology cards",
        "icon" => "🃏",
        "collection_id" => "550e8400-e29b-41d4-a716-446655440000",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end
end

defmodule EngramAPIWeb.SpacedRetrival.CardTypes.Dto do
  alias OpenApiSpex.Schema

  defmodule CreateCardTypeParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCardTypeParams",
      description: "Params to create a card type",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "Name of the card type"},
        description: %Schema{type: :string, description: "Description of the card type"},
        slug: %Schema{type: :string, description: "Unique slug for the card type"}
      },
      required: [:name, :description, :slug],
      example: %{
        "name" => "Flashcard",
        "description" => "Standard question and answer card",
        "slug" => "flashcard"
      }
    })
  end

  defmodule CreateCardTypeResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCardTypeResponse",
      description: "Response schema for creating a card type",
      type: :object,
      properties: %{
        id: %Schema{type: :string, format: :uuid},
        name: %Schema{type: :string},
        description: %Schema{type: :string},
        slug: %Schema{type: :string},
        inserted_at: %Schema{type: :string, format: :date_time},
        updated_at: %Schema{type: :string, format: :date_time, nullable: true}
      },
      example: %{
        "id" => "550e8400-e29b-41d4-a716-446655440000",
        "name" => "Flashcard",
        "description" => "Standard question and answer card",
        "slug" => "flashcard",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => nil
      }
    })
  end
end

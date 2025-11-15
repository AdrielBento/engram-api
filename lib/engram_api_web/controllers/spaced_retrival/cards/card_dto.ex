defmodule EngramAPIWeb.SpacedRetrival.Cards.Dto do
  alias OpenApiSpex.Schema

  defmodule CreateCardParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCardParams",
      description: "Params to create a card",
      type: :object,
      properties: %{
        question: %Schema{type: :string, description: "Prompt/question of the card"},
        answer: %Schema{type: :string, description: "Answer for the card"},
        hint: %Schema{type: :string, description: "Hint for the card"},
        evaluation_strategy: %Schema{
          type: :string,
          enum: ["rubric", "free"],
          description: "Evaluation strategy for the card"
        },
        how_to_evaluate: %Schema{
          type: :string,
          description: "Instructions on how to evaluate the answer"
        },
        deck_id: %Schema{type: :string, format: :uuid, description: "Deck identifier"}
      },
      required: [:question, :answer, :deck_id],
      example: %{
        "question" => "What is the capital of France?",
        "answer" => "Paris",
        "deck_id" => "550e8400-e29b-41d4-a716-446655440000"
      }
    })
  end

  defmodule CreateCardResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateCardResponse",
      description: "Response schema for creating a card",
      type: :object,
      properties: %{
        id: %Schema{type: :string, format: :uuid},
        question: %Schema{type: :string},
        answer: %Schema{type: :string},
        hint: %Schema{type: :string},
        evaluation_strategy: %Schema{type: :string, enum: ["rubric", "free"]},
        how_to_evaluate: %Schema{type: :string, nullable: true},
        deck_id: %Schema{type: :string, format: :uuid},
        state: %Schema{type: :string, enum: ["learning", "review", "relearning"]},
        step: %Schema{type: :integer},
        stability: %Schema{type: :number, format: :float, nullable: true},
        difficulty: %Schema{type: :number, format: :float, nullable: true},
        scheduled_days: %Schema{type: :integer, nullable: true},
        due: %Schema{type: :string, format: :date_time},
        last_review: %Schema{type: :string, format: :date_time, nullable: true},
        inserted_at: %Schema{type: :string, format: :date_time},
        updated_at: %Schema{type: :string, format: :date_time, nullable: true}
      },
      example: %{
        "id" => "550e8400-e29b-41d4-a716-446655440000",
        "question" => "What is the capital of France?",
        "answer" => "Paris",
        "hint" => "It's also known as the city of lights.",
        "evaluation_strategy" => "rubric",
        "how_to_evaluate" => nil,
        "deck_id" => "550e8400-e29b-41d4-a716-446655440000",
        "state" => "learning",
        "step" => 0,
        "stability" => nil,
        "difficulty" => nil,
        "scheduled_days" => nil,
        "due" => "2017-09-12T12:34:55Z",
        "last_review" => nil,
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => nil
      }
    })
  end
end

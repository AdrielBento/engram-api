defmodule EngramAPI.Domain.SpacedRetrival.Card do
  @enforce_keys [:question, :answer, :deck_id]
  defstruct [
    :id,
    :question,
    :answer,
    :hint,
    :evaluation_strategy,
    :how_to_evaluate,
    :deck_id,
    :state,
    :step,
    :stability,
    :difficulty,
    :scheduled_days,
    :due,
    :last_review,
    :inserted_at,
    :updated_at,
    :deleted_at
  ]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          question: String.t(),
          answer: String.t(),
          hint: String.t(),
          evaluation_strategy: :rubric | :free | nil,
          how_to_evaluate: String.t() | nil,
          deck_id: String.t(),
          state: :learning | :review | :relearning,
          step: non_neg_integer(),
          stability: float() | nil,
          difficulty: float() | nil,
          scheduled_days: non_neg_integer() | nil,
          due: DateTime.t(),
          last_review: DateTime.t() | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          deleted_at: DateTime.t() | nil
        }

  @default_state :learning
  @default_step 0

  @spec new(map()) :: {:ok, t()}
  def new(attrs) when is_map(attrs) do
    {:ok,
     %__MODULE__{
       id: fetch_attr(attrs, :id) || generate_id(),
       question: fetch_attr(attrs, :question),
       answer: fetch_attr(attrs, :answer),
       hint: fetch_attr(attrs, :hint),
       evaluation_strategy: fetch_attr(attrs, :evaluation_strategy),
       how_to_evaluate: fetch_attr(attrs, :how_to_evaluate),
       deck_id: fetch_attr(attrs, :deck_id),
       state: fetch_attr(attrs, :state, @default_state),
       step: fetch_attr(attrs, :step, @default_step),
       stability: fetch_attr(attrs, :stability),
       difficulty: fetch_attr(attrs, :difficulty),
       scheduled_days: fetch_attr(attrs, :scheduled_days),
       due: fetch_attr(attrs, :due, DateTime.utc_now()),
       last_review: fetch_attr(attrs, :last_review),
       inserted_at: fetch_attr(attrs, :inserted_at) || DateTime.utc_now(),
       updated_at: fetch_attr(attrs, :updated_at),
       deleted_at: fetch_attr(attrs, :deleted_at)
     }}
  end

  defp fetch_attr(attrs, key, default \\ nil) do
    Map.get(attrs, key) || Map.get(attrs, Atom.to_string(key)) || default
  end

  defp generate_id, do: Ecto.UUID.generate()
end

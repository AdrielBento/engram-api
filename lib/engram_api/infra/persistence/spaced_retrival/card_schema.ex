defmodule EngramAPI.Infrastructure.Persistence.SpacedRetrival.Card do
  use Ecto.Schema

  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.{Deck, ReviewLog}

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :question, :string
    field :answer, :string
    field :hint, :string

    # FSRS fields - matching the ExFsrs struct
    field :state, Ecto.Enum, values: [:learning, :review, :relearning], default: :learning
    field :step, :integer, default: 0
    field :stability, :float
    field :difficulty, :float
    field :scheduled_days, :integer
    field :due, :utc_datetime
    field :last_review, :utc_datetime
    field :deleted_at, :naive_datetime, default: nil

    belongs_to :deck, Deck
    has_many :review_logs, ReviewLog

    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [
      :question,
      :answer,
      :hint,
      :deck_id,
      :state,
      :step,
      :stability,
      :difficulty,
      :scheduled_days,
      :due,
      :last_review
    ])
    |> validate_required([:question, :answer, :deck_id])
  end
end

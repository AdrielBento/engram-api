defmodule EngramAPI.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :question, :string
    field :answer, :string

    # FSRS fields - matching the ExFsrs struct
    field :state, Ecto.Enum, values: [:learning, :review, :relearning], default: :learning
    field :step, :integer, default: 0
    field :stability, :float
    field :difficulty, :float
    field :scheduled_days, :integer
    field :due, :utc_datetime
    field :last_review, :utc_datetime

    belongs_to :deck, EngramAPI.Decks.Deck
    has_many :review_logs, EngramAPI.Cards.ReviewLog

    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [
      :question,
      :answer,
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

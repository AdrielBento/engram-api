defmodule EngramAPI.Cards.ReviewLog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "review_logs" do
    field :rating, Ecto.Enum, values: [:again, :hard, :good, :easy]
    field :review_datetime, :utc_datetime
    field :review_duration, :integer
    field :scheduled_days, :integer
    field :state, Ecto.Enum, values: [:learning, :review, :relearning]
    field :stability, :float
    field :difficulty, :float

    belongs_to :card, EngramAPI.Cards.Card

    timestamps()
  end

  def changeset(review_log, attrs) do
    review_log
    |> cast(attrs, [
      :card_id, :rating, :review_datetime, :review_duration,
      :scheduled_days, :state, :stability, :difficulty
    ])
    |> validate_required([:card_id, :rating, :review_datetime])
    |> foreign_key_constraint(:card_id)
  end
end

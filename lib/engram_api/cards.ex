defmodule EngramAPI.Cards do
  # import Ecto.Query, warn: false
  # alias EngramAPI.Repo
  # alias EngramAPI.Cards.Card
  # alias EngramAPI.Cards.ReviewLog

  # # Default FSRS parameters (you can make these configurable)
  # @default_parameters [
  #   0.4,
  #   0.6,
  #   2.4,
  #   5.8,
  #   4.93,
  #   0.94,
  #   0.86,
  #   0.01,
  #   1.49,
  #   0.14,
  #   0.94,
  #   2.18,
  #   0.05,
  #   0.34,
  #   1.26,
  #   0.29,
  #   2.61
  # ]

  # # Create a new card
  # def create_card(attrs \\ %{}) do
  #   # Initialize with default FSRS values for a new card
  #   fsrs_attrs = %{
  #     state: :learning,
  #     step: 0,
  #     stability: nil,
  #     difficulty: nil,
  #     due: DateTime.utc_now(),
  #     last_review: nil
  #   }

  #   attrs_with_fsrs = Map.merge(attrs, fsrs_attrs)

  #   %Card{}
  #   |> Card.changeset(attrs_with_fsrs)
  #   |> Repo.insert()
  # end

  # # Get a card by ID
  # def get_card(id), do: Repo.get(Card, id)

  # # Get due cards for a deck
  # def get_due_cards(deck_id) do
  #   now = DateTime.utc_now()

  #   from(c in Card,
  #     where: c.deck_id == ^deck_id and c.due <= ^now,
  #     order_by: [asc: c.due]
  #   )
  #   |> Repo.all()
  # end

  # # Review a card
  # def review_card(card_id, rating) when rating in 1..4 do
  #   with %Card{} = card <- get_card(card_id) do
  #     # Convert rating integer to atom
  #     rating_atom =
  #       case rating do
  #         1 -> :again
  #         2 -> :hard
  #         3 -> :good
  #         4 -> :easy
  #       end

  #     # Convert our database card to FSRS card structure
  #     fsrs_card = to_fsrs_card(card)

  #     # Get the scheduler
  #     scheduler = get_scheduler()

  #     # Perform the review using FSRS Scheduler
  #     {updated_fsrs_card, review_log} =
  #       ExFsrs.Scheduler.review_card(scheduler, fsrs_card, rating_atom)

  #     # Update our database card with the FSRS results
  #     card_attrs = from_fsrs_card(updated_fsrs_card)

  #     # Use a transaction to update card and create review log
  #     Repo.transaction(fn ->
  #       # Update the card
  #       {:ok, updated_card} =
  #         card
  #         |> Card.changeset(card_attrs)
  #         |> Repo.update()

  #       # Create review log entry
  #       create_review_log(review_log, card_id)

  #       updated_card
  #     end)
  #   end
  # end

  # defp get_scheduler do
  #   ExFsrs.Scheduler.new(
  #     parameters: @default_parameters,
  #     desired_retention: 0.9,
  #     learning_steps: [1.0, 10.0],
  #     relearning_steps: [10.0],
  #     maximum_interval: 36500,
  #     enable_fuzzing: true
  #   )
  # end

  # defp to_fsrs_card(card) do
  #   %ExFsrs{
  #     card_id: card.id,
  #     state: card.state,
  #     step: card.step,
  #     stability: card.stability,
  #     difficulty: card.difficulty,
  #     due: card.due,
  #     last_review: card.last_review
  #   }
  # end

  # defp from_fsrs_card(fsrs_card) do
  #   %{
  #     state: fsrs_card.state,
  #     step: fsrs_card.step,
  #     stability: fsrs_card.stability,
  #     difficulty: fsrs_card.difficulty,
  #     due: fsrs_card.due,
  #     last_review: fsrs_card.last_review
  #   }
  # end

  # defp create_review_log(review_log, card_id) do
  #   attrs = %{
  #     card_id: card_id,
  #     rating: review_log.rating,
  #     review_datetime: review_log.review_datetime,
  #     review_duration: review_log.review_duration,
  #     # Store the card state at the time of review
  #     scheduled_days: review_log.card.scheduled_days,
  #     state: review_log.card.state,
  #     stability: review_log.card.stability,
  #     difficulty: review_log.card.difficulty
  #   }

  #   %ReviewLog{}
  #   |> ReviewLog.changeset(attrs)
  #   |> Repo.insert!()
  # end

  # # Get card statistics
  # def get_card_stats(deck_id) do
  #   now = DateTime.utc_now()

  #   due_count =
  #     from(c in Card,
  #       where: c.deck_id == ^deck_id and c.due <= ^now,
  #       select: count(c.id)
  #     )
  #     |> Repo.one()

  #   total_count =
  #     from(c in Card, where: c.deck_id == ^deck_id, select: count(c.id))
  #     |> Repo.one()

  #   %{
  #     due: due_count,
  #     total: total_count,
  #     studied: total_count - due_count
  #   }
  # end

  # # Get review history for a card
  # def get_review_history(card_id) do
  #   from(rl in ReviewLog,
  #     where: rl.card_id == ^card_id,
  #     order_by: [desc: rl.review_datetime]
  #   )
  #   |> Repo.all()
  # end

  # # Get cards for a deck with pagination
  # def list_cards(deck_id, page \\ 1, page_size \\ 20) do
  #   query = from(c in Card, where: c.deck_id == ^deck_id, order_by: [desc: c.inserted_at])

  #   Repo.all(query)
  # end
end

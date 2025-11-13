defmodule EngramAPI.DeckFactory do
  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Deck,
    as: DeckSchema

  defmacro __using__(_opts) do
    quote do
      def deck_factory do
        %DeckSchema{
          name:
            sequence(:deck_name, fn idx ->
              "deck-#{idx}-#{Faker.Lorem.word()}"
            end),
          description: Faker.Lorem.sentence(),
          icon: "🃏"
        }
      end
    end
  end
end

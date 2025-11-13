defmodule EngramAPI.CardFactory do
  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Card,
    as: CardSchema

  defmacro __using__(_opts) do
    quote do
      def card_factory do
        %CardSchema{
          question:
            sequence(:card_question, fn idx ->
              "What is term #{idx}?"
            end),
          answer: sequence(:card_answer, fn idx -> "Answer #{idx}" end)
        }
      end
    end
  end
end

defmodule EngramAPI.CardTypeFactory do
  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.CardType,
    as: CardTypeSchema

  defmacro __using__(_opts) do
    quote do
      def card_type_factory do
        %CardTypeSchema{
          name: sequence(:card_type_name, &"Card type #{&1}"),
          description: sequence(:card_type_description, &"Description #{&1}"),
          slug: sequence(:card_type_slug, &"card-type-#{&1}")
        }
      end
    end
  end
end

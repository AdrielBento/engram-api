defmodule EngramAPI.CollectionFactory do
  alias EngramAPI.Infrastructure.Persistence.SpacedRetrival.Collection,
    as: CollectionSchema

  defmacro __using__(_opts) do
    quote do
      def collection_factory do
        %CollectionSchema{
          name:
            sequence(:collection_name, fn idx ->
              "collection-#{idx}-#{Faker.Lorem.word()}"
            end),
          description: Faker.Lorem.sentence(),
          icon: "📚"
        }
      end
    end
  end
end

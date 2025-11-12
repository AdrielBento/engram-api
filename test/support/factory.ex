defmodule EngramAPI.Factory do
  @moduledoc "Test data factories"

  use ExMachina

  def collection_params_factory do
    %{
      name: sequence(:collection_name, fn idx ->
        "collection-#{idx}-#{Faker.Lorem.word()}"
      end),
      description: Faker.Lorem.sentence(),
      icon: "📚"
    }
  end
end

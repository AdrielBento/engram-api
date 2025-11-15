defmodule EngramAPI.Factory do
  @moduledoc "Test data factories"

  use ExMachina.Ecto, repo: EngramAPI.Repo
  use EngramAPI.CollectionFactory
  use EngramAPI.DeckFactory
  use EngramAPI.CardFactory
  use EngramAPI.CardTypeFactory
end

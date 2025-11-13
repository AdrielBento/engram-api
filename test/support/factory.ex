defmodule EngramAPI.Factory do
  @moduledoc "Test data factories"

  use ExMachina.Ecto, repo: EngramAPI.Repo
  use EngramAPI.CollectionFactory
  use EngramAPI.DeckFactory
end

defmodule EngramAPI.Domain.SpacedRetrival.CardType do
  @enforce_keys [:name, :description, :slug]
  defstruct [
    :id,
    :name,
    :description,
    :slug,
    :inserted_at,
    :updated_at,
    :deleted_at
  ]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t(),
          description: String.t(),
          slug: String.t(),
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          deleted_at: DateTime.t() | nil
        }

  @spec new(map()) :: {:ok, t()}
  def new(attrs) when is_map(attrs) do
    {:ok,
     %__MODULE__{
       id: fetch_attr(attrs, :id) || generate_id(),
       name: fetch_attr(attrs, :name),
       description: fetch_attr(attrs, :description),
       slug: fetch_attr(attrs, :slug),
       inserted_at: fetch_attr(attrs, :inserted_at) || DateTime.utc_now(),
       updated_at: fetch_attr(attrs, :updated_at),
       deleted_at: fetch_attr(attrs, :deleted_at)
     }}
  end

  defp fetch_attr(attrs, key, default \\ nil) do
    Map.get(attrs, key) || Map.get(attrs, Atom.to_string(key)) || default
  end

  defp generate_id, do: Ecto.UUID.generate()
end

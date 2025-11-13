defmodule EngramAPI.Domain.SpacedRetrival.Deck do
  @enforce_keys [:name, :description, :icon, :collection_id]
  defstruct [
    :id,
    :name,
    :description,
    :icon,
    :collection_id,
    :inserted_at,
    :updated_at,
    :deleted_at
  ]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t(),
          description: String.t(),
          icon: String.t(),
          collection_id: String.t(),
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          deleted_at: DateTime.t() | nil
        }

  @spec new(map()) :: {:ok, t()}
  def new(attrs) when is_map(attrs) do
    {:ok,
     %__MODULE__{
       id: Map.get(attrs, :id) || Map.get(attrs, "id") || generate_id(),
       name: fetch_attr(attrs, :name),
       description: fetch_attr(attrs, :description),
       icon: fetch_attr(attrs, :icon),
       collection_id: fetch_attr(attrs, :collection_id),
       inserted_at: Map.get(attrs, :inserted_at) || Map.get(attrs, "inserted_at") || DateTime.utc_now(),
       updated_at: Map.get(attrs, :updated_at) || Map.get(attrs, "updated_at"),
       deleted_at: Map.get(attrs, :deleted_at) || Map.get(attrs, "deleted_at")
     }}
  end

  defp fetch_attr(attrs, key) do
    Map.get(attrs, key) || Map.get(attrs, Atom.to_string(key))
  end

  defp generate_id, do: Ecto.UUID.generate()
end

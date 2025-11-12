defmodule EngramAPI.Domain.SpacedRetrival.Collection do
  @enforce_keys [:name, :description, :icon]
  defstruct [:id, :name, :description, :icon, :inserted_at, :updated_at, :deleted_at]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t(),
          description: String.t(),
          icon: String.t(),
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          deleted_at: DateTime.t() | nil
        }

  def new(attrs) do
    {:ok,
     %__MODULE__{
       id: Map.get(attrs, :id) || Map.get(attrs, "id") || generate_id(),
       name: attrs.name,
       description: attrs.description,
       icon: attrs.icon,
       inserted_at: DateTime.utc_now()
     }}
  end

  defp generate_id, do: Ecto.UUID.generate()
end

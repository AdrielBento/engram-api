defmodule EngramAPI.Repo do
  use Ecto.Repo,
    otp_app: :engram_api,
    adapter: Ecto.Adapters.Postgres
end

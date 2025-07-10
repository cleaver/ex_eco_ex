defmodule Ecoexpense.Repo do
  use Ecto.Repo,
    otp_app: :ecoexpense,
    adapter: Ecto.Adapters.Postgres
end

defmodule Wabanex.Repo do # I use this module to interact with the database.
  use Ecto.Repo,
    otp_app: :wabanex,
    adapter: Ecto.Adapters.Postgres
end

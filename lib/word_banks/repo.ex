defmodule WordBanks.Repo do
  use Ecto.Repo,
    otp_app: :word_banks,
    adapter: Ecto.Adapters.Postgres
end

use Mix.Config

# Configure your database
config :word_banks, WordBanks.Repo,
  username: "postgres",
  password: "postgres",
  database: "word_banks_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :word_banks, WordBanksWeb.Endpoint,
  http: [port: 4002],
  server: false,
  secret_key_base: "3PXN/6k6qoxqQjWFskGew4r74yp7oJ1UNF6wjvJSHjC5Y5LLIrDpWxrJ84UBphJn"

# Print only warnings and errors during test
config :logger, level: :warn

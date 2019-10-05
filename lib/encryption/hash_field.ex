defmodule WordBanks.HashField do
  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value) do
    {:ok, to_string(value)}
  end

  def dump(value) do
    {:ok, hash(value)}
  end

  def load(value) do
    {:ok, value}
  end

  def hash(value) do
    get_salt(value)
    |> IO.inspect(label: "get_salt")

    :crypto.hash(:sha256, value <> get_salt(value))
  end

  # Get/use Phoenix secret_key_base as "salt" for one-way hashing Email address
  # use the *value* to create a *unique* "salt" for each value that is hashed:
  defp get_salt(value) do
    secret_key_base = Application.get_env(:word_banks, WordBanksWeb.Endpoint)[:secret_key_base]
    :crypto.hash(:sha256, value <> secret_key_base)
  end
end
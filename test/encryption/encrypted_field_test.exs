defmodule WordBanks.Encryption.EncryptedFieldTest do
  use ExUnit.Case
  # our Ecto Custom Type for hashed fields
  alias WordBanks.Encryption.EncryptedField, as: Field

  test ".type is :binary" do
    assert Field.type() == :binary
  end

  test ".cast converts a value to a string" do
    assert {:ok, "42"} == Field.cast(42)
    assert {:ok, "atom"} == Field.cast(:atom)
  end

  test ".dump converts a value to a AES encrypted hash" do
    {:ok, ciphertext} = Field.dump("hello")
    assert is_binary(ciphertext)
    assert ciphertext != "hello"
    assert String.length(ciphertext) != 0
  end

  test ".load does not modify the hash, since the hash cannot be reversed" do
    {:ok, ciphertext} = Field.dump("hello")
    keys = Application.get_env(:word_banks, WordBanks.Encryption.AES)[:keys]
    key_id = Enum.count(keys) - 1
    assert {:ok, "hello"} == Field.load(ciphertext, key_id)
  end
end

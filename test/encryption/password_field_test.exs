defmodule WordBanks.Encryption.PasswordFieldTest do
  use ExUnit.Case
  alias WordBanks.Encryption.PasswordField, as: Field

  test "hash_password/1 uses Argon2id to Hash a value" do
    password = "EverythingisAwesome"
    hash = Field.hash_password(password)
    verified = Argon2.verify_pass(password, hash)
    assert verified
  end

  test "verify_password checks the password against the Argon2id Hash" do
    password = "EverythingisAwesome"
    hash = Field.hash_password(password)
    verified = Field.verify_password(password, hash)
    assert verified
  end

  test ".verify_password fails if password does NOT match hash" do
    password = "EverythingisAwesome"
    hash = Field.hash_password(password)
    verified = Field.verify_password("LordBusiness", hash)
    assert !verified
  end
end

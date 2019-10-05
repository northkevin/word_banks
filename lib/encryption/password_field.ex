defmodule WordBanks.Encryption.PasswordField do
  def hash_password(value) do
    Argon2.Base.hash_password(to_string(value), Argon2.gen_salt(), [{:argon2_type, 2}])
  end

  def verify_password(password, stored_hash) do
    Argon2.verify_pass(password, stored_hash)
  end
end

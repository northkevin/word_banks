defmodule WordBanks.PasswordField do
  def hash_password(value) do
    Argon2.Base.hash_password(to_string(value), Argon2.gen_salt(), [{:argon2_type, 2}])
  end
end

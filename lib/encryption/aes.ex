defmodule WordBanks.Encryption.AES do
  # Use AES 256 Bit Keys for Encryption.
  @aad "AES256GCM"

  def encrypt(plaintext) do
    # create random Initialisation Vector
    iv = :crypto.strong_rand_bytes(16)
    # get the *latest* key in the list of encryption keys
    key = get_key()
    {ciphertext, tag} = :crypto.block_encrypt(:aes_gcm, key, iv, {@aad, to_string(plaintext), 16})
    # "return" iv with the cipher tag & ciphertext
    iv <> tag <> ciphertext
  end

  def decrypt(ciphertext) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, get_key(), iv, {@aad, ciphertext, tag})
  end

  def decrypt(ciphertext, key_id) do
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, get_key(key_id), iv, {@aad, ciphertext, tag})
  end

  defp get_key do
    keys = Application.get_env(:word_banks, WordBanks.Encryption.AES)[:keys]
    # get the last/latest key from the key list
    count = Enum.count(keys) - 1
    # use get_key/1 to retrieve the desired encryption key.
    get_key(count)
  end

  defp get_key(key_id) do
    # cached call
    keys = Application.get_env(:word_banks, WordBanks.Encryption.AES)[:keys]
    # retrieve the desired key by key_id from keys list.
    Enum.at(keys, key_id)
  end

  # # this is a "dummy function" we will update it in step 3.3
  # defp get_key do
  #   <<
  #     109,
  #     182,
  #     30,
  #     109,
  #     203,
  #     207,
  #     35,
  #     144,
  #     228,
  #     164,
  #     106,
  #     244,
  #     38,
  #     242,
  #     106,
  #     19,
  #     58,
  #     59,
  #     238,
  #     69,
  #     2,
  #     20,
  #     34,
  #     252,
  #     122,
  #     232,
  #     110,
  #     145,
  #     54,
  #     # return a random 32 Byte / 128 bit binary to use as key.
  #     241,
  #     65,
  #     16
  #   >>
  # end
end

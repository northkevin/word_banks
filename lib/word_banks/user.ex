defmodule WordBanks.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias WordBanks.Encryption.{EncryptedField, HashField, PasswordField}
  alias WordBanks.{User, Repo}

  schema "users" do
    field :email, EncryptedField
    field :email_hash, HashField
    field :key_id, :integer
    field :name, EncryptedField
    field :password_hash, :binary

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> Map.merge(attrs)
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    # set the email_hash field
    |> set_hashed_fields
    # check email_hash is not already in DB
    |> unique_constraint(:email_hash)
    |> encrypt_fields
  end

  defp encrypt_fields(changeset) do
    case changeset.valid? do
      true ->
        {:ok, encrypted_email} = EncryptedField.dump(changeset.data.email)
        {:ok, encrypted_name} = EncryptedField.dump(changeset.data.name)

        changeset
        |> put_change(:email, encrypted_email)
        |> put_change(:name, encrypted_name)

      _ ->
        changeset
    end
  end

  defp set_hashed_fields(changeset) do
    case changeset.valid? do
      true ->
        changeset
        |> put_change(:email_hash, HashField.hash(changeset.data.email))
        |> put_change(
          :password_hash,
          PasswordField.hash_password(changeset.data.password)
        )

      _ ->
        # return unmodified
        changeset
    end
  end
end

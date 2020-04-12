defmodule Flow.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  User entity are used to manager Jaya Users
  """

  @derive {Jason.Encoder, only: [:email, :name, :id, :avatar]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :admin, :boolean, default: false
    field :avatar, :string
    field :email, :string
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :token, :admin, :avatar])
    |> validate_required([:name, :email, :token, :admin, :avatar])
    |> unique_constraint(:email)
  end
end

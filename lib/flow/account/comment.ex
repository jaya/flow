defmodule Flow.Account.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :text, :string
    field :candidate_id, :binary_id
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end

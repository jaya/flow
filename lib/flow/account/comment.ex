defmodule Flow.Account.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flow.Jobs.Candidate
  alias Flow.Account.User

  @moduledoc """
  Comment is used to talk about candidate
  """

  @derive {Jason.Encoder, only: [:id, :text, :user, :inserted_at]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :text, :string
    belongs_to :candidate, Candidate
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :candidate_id, :user_id])
    |> validate_required([:text, :candidate_id, :user_id])
  end
end

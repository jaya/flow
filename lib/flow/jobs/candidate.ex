defmodule Flow.Jobs.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flow.Account.Comment

  @moduledoc """
  Candidate represent candidate entity
  """

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "candidates" do
    field :email, :string
    field :github, :string
    field :linkedin, :string
    field :name, :string
    field :phone, :string
    belongs_to :status, Flow.Jobs.Status
    belongs_to :job, Flow.Jobs.Job
    belongs_to :user, Flow.Account.User
    has_many :comments, Comment, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :email, :phone, :linkedin, :github, :status_id, :job_id, :user_id])
    |> validate_required([:name, :email, :status_id, :job_id, :user_id])
    |> unique_constraint(:email)
  end
end

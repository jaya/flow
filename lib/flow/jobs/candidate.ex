defmodule Flow.Jobs.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

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

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :email, :phone, :linkedin, :github, :status_id, :job_id])
    |> validate_required([:name, :email, :phone, :linkedin, :github, :status_id, :job_id])
    |> unique_constraint(:email)
  end
end

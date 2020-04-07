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
    field :status_id, :binary_id
    field :job_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :email, :phone, :linkedin, :github])
    |> validate_required([:name, :email, :phone, :linkedin, :github])
    |> unique_constraint(:email)
  end
end

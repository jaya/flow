defmodule Flow.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "jobs" do
    field :description, :string
    field :name, :string
    field :positions, :integer
    belongs_to :client, Flow.Jobs.Client
    has_many :cadidates, Flow.Jobs.Candidate
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :description, :positions, :client_id])
    |> validate_required([:name, :description, :positions, :client_id])
  end
end

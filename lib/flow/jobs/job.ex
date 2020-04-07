defmodule Flow.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "jobs" do
    field :description, :string
    field :name, :string
    field :positions, :integer
    field :client_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :description, :positions])
    |> validate_required([:name, :description, :positions])
  end
end

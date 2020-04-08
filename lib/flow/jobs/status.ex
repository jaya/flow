defmodule Flow.Jobs.Status do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "status" do
    field :description, :string
    field :enable, :boolean, default: false
    field :name, :string
    field :order, :integer
    has_many :candidates, Flow.Jobs.Candidate
    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name, :description, :order, :enable])
    |> validate_required([:name, :description, :order, :enable])
    |> unique_constraint(:name)
  end
end

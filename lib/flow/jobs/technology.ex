defmodule Flow.Jobs.Technology do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "technologies" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(technology, attrs) do
    technology
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end

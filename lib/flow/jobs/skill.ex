defmodule Flow.Jobs.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "skills" do
    field :candidate_id, :binary_id
    field :technology_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [])
    |> validate_required([])
  end
end

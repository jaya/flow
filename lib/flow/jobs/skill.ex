defmodule Flow.Jobs.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "skills" do
    belongs_to :candidate, Flow.Jobs.Candidate
    belongs_to :technology, Flow.Jobs.Technology

    timestamps()
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:technology_id, :candidate_id])
    |> validate_required([:technology_id, :candidate_id])
  end
end

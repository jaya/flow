defmodule Flow.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :candidate_id, references(:candidates, on_delete: :nothing, type: :binary_id)
      add :technology_id, references(:technologies, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:skills, [:candidate_id])
    create index(:skills, [:technology_id])
  end
end

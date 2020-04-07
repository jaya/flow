defmodule Flow.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :phone, :string
      add :linkedin, :string
      add :github, :string
      add :status_id, references(:status, on_delete: :nothing, type: :binary_id)
      add :job_id, references(:jobs, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:candidates, [:email])
    create index(:candidates, [:status_id])
    create index(:candidates, [:job_id])
  end
end

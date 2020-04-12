defmodule Flow.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :phone, :string, null: true
      add :salary, :decimal, null: true
      add :linkedin, :string, null: true
      add :github, :string, null: true
      add :status_id, references(:status, on_delete: :nothing, type: :binary_id)
      add :job_id, references(:jobs, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:candidates, [:email])
    create index(:candidates, [:status_id])
    create index(:candidates, [:job_id])
  end
end

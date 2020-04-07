defmodule Flow.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :positions, :integer
      add :client_id, references(:clients, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:jobs, [:client_id])
  end
end

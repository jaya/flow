defmodule Flow.Repo.Migrations.CreateTechnologies do
  use Ecto.Migration

  def change do
    create table(:technologies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:technologies, [:name])
  end
end

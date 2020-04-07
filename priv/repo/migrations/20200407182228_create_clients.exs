defmodule Flow.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :logo, :string

      timestamps()
    end

  end
end

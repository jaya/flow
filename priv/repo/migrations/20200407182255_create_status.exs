defmodule Flow.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:status, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :order, :integer
      add :enable, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:status, [:name])
  end
end

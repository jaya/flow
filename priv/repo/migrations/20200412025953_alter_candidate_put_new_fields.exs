defmodule Flow.Repo.Migrations.AlterCandidatePutNewFields do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :user_id, references(:users, type: :binary_id)
    end
  end
end

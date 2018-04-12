defmodule Confer.Repo.Migrations.AddStatusIdToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :status_id, references(:statuses), default: 1
    end
  end
end

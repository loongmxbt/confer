defmodule Confer.Repo.Migrations.AddRoleIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role_id, references(:roles), default: 1
    end
  end
end

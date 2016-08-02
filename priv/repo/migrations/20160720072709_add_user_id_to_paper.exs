defmodule Confer.Repo.Migrations.AddUserIdToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :user_id, references(:users)
    end
  end
end

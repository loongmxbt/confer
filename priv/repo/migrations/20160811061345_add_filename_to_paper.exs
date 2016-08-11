defmodule Confer.Repo.Migrations.AddFilenameToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :filename, :string
    end
  end
end

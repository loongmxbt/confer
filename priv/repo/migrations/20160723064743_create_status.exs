defmodule Confer.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :name, :string

      timestamps()
    end

  end
end

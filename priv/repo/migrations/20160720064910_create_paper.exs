defmodule Confer.Repo.Migrations.CreatePaper do
  use Ecto.Migration

  def change do
    create table(:papers) do
      add :title, :string
      add :file, :string

      timestamps()
    end

  end
end

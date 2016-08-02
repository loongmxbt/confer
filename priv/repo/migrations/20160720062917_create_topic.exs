defmodule Confer.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string

      timestamps()
    end

    create unique_index(:topics, [:name])
  end
end

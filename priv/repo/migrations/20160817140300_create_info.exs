defmodule Confer.Repo.Migrations.CreateInfo do
  use Ecto.Migration

  def change do
    create table(:infos) do
      add :slug, :string
      add :name, :string
      add :content, :text

      timestamps()
    end

    create unique_index(:infos, [:slug])

  end
end

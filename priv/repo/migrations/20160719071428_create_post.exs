defmodule Confer.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text

      timestamps()
    end

  end
end

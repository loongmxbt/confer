defmodule Confer.Repo.Migrations.AddFileContentTypeToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :content_type, :string
    end
  end
end

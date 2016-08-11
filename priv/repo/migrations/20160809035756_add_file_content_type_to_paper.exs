defmodule Confer.Repo.Migrations.AddFileContentTypeToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :file_content_type, :string
    end
  end
end

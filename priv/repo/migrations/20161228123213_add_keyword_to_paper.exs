defmodule Confer.Repo.Migrations.AddKeywordToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :keyword, :string
    end
  end
end

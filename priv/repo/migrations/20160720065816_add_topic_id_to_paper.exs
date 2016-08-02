defmodule Confer.Repo.Migrations.AddTopicIdToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :topic_id, references(:topics)
    end
  end
end

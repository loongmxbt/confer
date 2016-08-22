defmodule Confer.Repo.Migrations.AddTopicIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :topic_id, references(:topics)
    end
  end
end

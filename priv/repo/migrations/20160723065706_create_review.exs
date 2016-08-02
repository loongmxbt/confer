defmodule Confer.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :content, :text
      add :status_id, references(:statuses, on_delete: :nothing)
      add :paper_id, references(:papers, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:reviews, [:status_id])
    create index(:reviews, [:paper_id])
    create index(:reviews, [:user_id])

  end
end

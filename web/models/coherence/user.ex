defmodule Confer.User do
  use Confer.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    coherence_schema
    belongs_to :role, Confer.Role
    belongs_to :topic, Confer.Topic
    has_many :papers, Confer.Paper
    has_many :reviews, Confer.Review

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :role_id, :topic_id] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end
end

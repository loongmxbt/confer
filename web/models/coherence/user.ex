defmodule Confer.User do
  @moduledoc false
  use Confer.Web, :model
  use Ecto.Schema
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    coherence_schema()
    belongs_to :role, Confer.Role
    belongs_to :topic, Confer.Topic
    has_many :papers, Confer.Paper
    has_many :reviews, Confer.Review

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :role_id, :topic_id] ++ coherence_fields())
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(password password_confirmation reset_password_token reset_password_sent_at))
    |> validate_coherence_password_reset(params)
  end
end

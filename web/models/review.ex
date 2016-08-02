defmodule Confer.Review do
  use Confer.Web, :model

  schema "reviews" do
    field :content, :string
    belongs_to :status, Confer.Status
    belongs_to :paper, Confer.Paper
    belongs_to :user, Confer.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :status_id, :paper_id, :user_id])
    |> validate_required([:status_id, :paper_id, :user_id])
  end
end

defmodule Confer.Page do
  use Confer.Web, :model

  schema "pages" do
    field :title, :string
    field :slug, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :content])
    |> validate_required([:title, :slug, :content])
  end
end

defmodule Confer.Info do
  use Confer.Web, :model

  schema "infos" do
    field :slug, :string
    field :name, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :content])
    |> validate_required([:name, :slug, :content])
  end
end

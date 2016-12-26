defmodule Confer.Status do
  use Confer.Web, :model

  schema "statuses" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def order_by_id(query) do
    from s in query, order_by: s.id
  end

  def select_names_and_ids(query) do
    from s in query, select: {s.name, s.id}
  end

end

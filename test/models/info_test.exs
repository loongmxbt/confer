defmodule Confer.InfoTest do
  use Confer.ModelCase

  alias Confer.Info

  @valid_attrs %{content: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Info.changeset(%Info{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Info.changeset(%Info{}, @invalid_attrs)
    refute changeset.valid?
  end
end

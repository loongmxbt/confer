defmodule Confer.PaperTest do
  use Confer.ModelCase

  alias Confer.Paper

  @valid_attrs %{file_name: "some content", file_url: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Confer.changeset(%Paper{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Confer.changeset(%Paper{}, @invalid_attrs)
    refute changeset.valid?
  end
end

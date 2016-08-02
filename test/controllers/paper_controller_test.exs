defmodule Confer.PaperControllerTest do
  use Confer.ConnCase

  alias Confer.Paper
  @valid_attrs %{file_name: "some content", file_url: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, paper_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing papers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, paper_path(conn, :new)
    assert html_response(conn, 200) =~ "New paper"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, paper_path(conn, :create), paper: @valid_attrs
    assert redirected_to(conn) == paper_path(conn, :index)
    assert Repo.get_by(Paper, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, paper_path(conn, :create), paper: @invalid_attrs
    assert html_response(conn, 200) =~ "New paper"
  end

  test "shows chosen resource", %{conn: conn} do
    paper = Repo.insert! %Paper{}
    conn = get conn, paper_path(conn, :show, paper)
    assert html_response(conn, 200) =~ "Show paper"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, paper_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    paper = Repo.insert! %Paper{}
    conn = get conn, paper_path(conn, :edit, paper)
    assert html_response(conn, 200) =~ "Edit paper"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    paper = Repo.insert! %Paper{}
    conn = put conn, paper_path(conn, :update, paper), paper: @valid_attrs
    assert redirected_to(conn) == paper_path(conn, :show, paper)
    assert Repo.get_by(Paper, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    paper = Repo.insert! %Paper{}
    conn = put conn, paper_path(conn, :update, paper), paper: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit paper"
  end

  test "deletes chosen resource", %{conn: conn} do
    paper = Repo.insert! %Paper{}
    conn = delete conn, paper_path(conn, :delete, paper)
    assert redirected_to(conn) == paper_path(conn, :index)
    refute Repo.get(Paper, paper.id)
  end
end

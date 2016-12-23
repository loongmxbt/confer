defmodule Confer.PaperController do
  use Confer.Web, :controller

  alias Confer.Topic
  alias Confer.User
  alias Confer.Paper
  alias Confer.Info

  plug :load_topics when action in [:new, :create, :edit, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  defp user_papers(user) do
    assoc(user, :papers)
  end

  def index(conn, _params, user) do
    # topics_query = from t in Topic, select: t.name
    # users_query = from u in User, select: u.name

    # papers = Repo.all(from p in Paper,
    #                   preload: [topic: ^topics_query, user: ^users_query])

    papers = Repo.all(user_papers(user)) |> Repo.preload(:topic)

    # IO.inspect papers
    render(conn, "index.html", papers: papers)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:papers)
      |> Paper.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"paper" => paper_params}, user) do
    # IO.inspect paper_params
    changeset =
      user
      |> build_assoc(:papers)
      |> Paper.changeset(paper_params)

    case Repo.insert(changeset) do
      {:ok, _paper} ->
        conn
        |> put_flash(:info, "Paper created successfully.")
        |> redirect(to: paper_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do

    paper = Repo.get!(Paper, id)
    if paper.user_id == user.id do
      pid = paper.id
      topic = Repo.get!(Topic, paper.topic_id)
      query = from r in "reviews",
              where: r.paper_id == ^pid,
              select: %{status_id: r.status_id, content: r.content}
      reviews = Repo.all(query)

      render(conn, "show.html", paper: paper, topic: topic, reviews: reviews)
    else
      redirect conn, to: "/papers"
    end

  end

  def edit(conn, %{"id" => id}, user) do
    paper = Repo.get!(Paper, id)
    changeset = Paper.changeset(paper)
    render(conn, "edit.html", paper: paper, changeset: changeset)
  end

  def update(conn, %{"id" => id, "paper" => paper_params}, user) do
    paper = Repo.get!(Paper, id)
    changeset = Paper.changeset(paper, paper_params)

    case Repo.update(changeset) do
      {:ok, paper} ->
        conn
        |> put_flash(:info, "Paper updated successfully.")
        |> redirect(to: paper_path(conn, :show, paper))
      {:error, changeset} ->
        render(conn, "edit.html", paper: paper, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    paper = Repo.get!(Paper, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(paper)

    conn
    |> put_flash(:info, "Paper deleted successfully.")
    |> redirect(to: paper_path(conn, :index))
  end

  defp load_topics(conn, _) do
    query =
      Topic
      |> Topic.order_by_id
      |> Topic.select_names_and_ids
    topics = Repo.all query
    assign(conn, :topics, topics)
  end

end

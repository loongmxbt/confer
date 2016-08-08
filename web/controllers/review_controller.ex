defmodule Confer.ReviewController do
  use Confer.Web, :controller

  # Review Controller is for professor
  alias Confer.Review
  alias Confer.Paper
  alias Confer.Status

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  defp user_reviews(user) do
    assoc(user, :reviews)
  end

  def index(conn, _params, user) do
    reviews = Repo.all(user_reviews(user)) |> Repo.preload(:paper) |> Repo.preload(:status)
    # reviews = Repo.all(Review)
    render(conn, "index.html", reviews: reviews)
  end

  # def new(conn, _params) do
  #   changeset = Review.changeset(%Review{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"review" => review_params}) do
  #   changeset = Review.changeset(%Review{}, review_params)
  #
  #   case Repo.insert(changeset) do
  #     {:ok, _review} ->
  #       conn
  #       |> put_flash(:info, "Review created successfully.")
  #       |> redirect(to: review_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}, user) do
    review = Repo.get!(Review, id) |> Repo.preload(:status)
    paper = Repo.get!(Paper, review.paper_id) |> Repo.preload(:user) |> Repo.preload(:topic)
    render(conn, "show.html", review: review, paper: paper)
  end

  def edit(conn, %{"id" => id}, user) do
    review = Repo.get!(Review, id)
    query = from s in Status, select: {s.name, s.id}
    statuses = Repo.all(Status)
    changeset = Review.changeset(review)
    render(conn, "edit.html", review: review, statuses: statuses, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}, user) do
    review = Repo.get!(Review, id)
    changeset = Review.changeset(review, review_params)

    case Repo.update(changeset) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: review_path(conn, :show, review))
      {:error, changeset} ->
        render(conn, "edit.html", review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    review = Repo.get!(Review, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: review_path(conn, :index))
  end


end

defmodule Confer.BackendController do
  use Confer.Web, :controller

  # Backend controller is for admin
  alias Confer.User
  alias Confer.Paper

  def index(conn, _params) do
    render conn, "index.html"
  end

  def index_reviews(conn, _params) do
    query = from u in User,
            where: u.role_id == 2
    professors = Repo.all(query)

    papers = Repo.all(Paper)
             |> Repo.preload(:topic)
             |> Repo.preload(:reviews)

    render(conn, "reviews.html", professors: professors, papers: papers)
    # list papers
    # list profs

  end


end

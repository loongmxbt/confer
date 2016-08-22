defmodule Confer.PageController do
  use Confer.Web, :controller

  alias Confer.{Page, Post, Info}

  def index(conn, _params) do
    query = from p in Post,
            select: [:id, :title, :inserted_at],
            limit: 5,
            order_by: [desc: p.inserted_at]
    recent_posts = Repo.all(query)
    # welcome text, email, address, etc
    # Move to page view
    welcome = Repo.get_by(Page, slug: "welcome")

    render(conn, "index.html", posts: recent_posts,
                               welcome: welcome)
  end

  def show(conn, %{"slug" => slug}) do
    page = Repo.get_by!(Page, slug: slug)
    render(conn, "show.html", page: page)
  end

end

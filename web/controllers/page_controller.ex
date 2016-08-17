defmodule Confer.PageController do
  use Confer.Web, :controller

  alias Confer.{Page, Post, Info}

  def index(conn, _params) do
    query = from p in Post,
            select: %{id: p.id, title: p.title},
            limit: 5,
            order_by: [desc: p.inserted_at]
    recent_posts = Repo.all(query)
    # welcome text, email, address, etc
    welcome = Repo.get(Post, 1)
    address = Repo.get_by(Info, slug: "address")
    phone = Repo.get_by(Info, slug: "phone")
    email = Repo.get_by(Info, slug: "email")
    wechat = Repo.get_by(Info, slug: "wechat")
    render(conn, "index.html", posts: recent_posts,
                               welcome: welcome,
                               address: address,
                               phone: phone,
                               email: email,
                               wechat: wechat)
  end

  def show(conn, %{"slug" => slug}) do
    page = Repo.get_by!(Page, slug: slug)
    render(conn, "show.html", page: page)
  end

end

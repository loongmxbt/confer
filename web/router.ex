defmodule Confer.Router do
  use Confer.Web, :router
  use Coherence.Router
  use ExAdmin.Router

  forward "/attachments", Exfile.Router

  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, login: true
  end

  pipeline :auth_admin do
    plug :auth_role, "admin"
  end

  pipeline :auth_professor do
    plug :auth_role, "professor"
  end

  pipeline :backend_layout do
    plug :put_layout, {Confer.BackendView, "app.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Coherence
  scope "/" do
    pipe_through :public
    coherence_routes :public
  end

  scope "/" do
    pipe_through :browser
    coherence_routes :private
  end

  # Public pages and posts
  scope "/", Confer do
    pipe_through :public
    get "/", PageController, :index
    get "/page/:slug", PageController, :show
    resources "/posts", PostController, only: [:index, :show]
  end

  # Login user paper submit
  scope "/", Confer do
    pipe_through :browser
    resources "/papers", PaperController # Login User CRUD paper
  end

  # Login professor role for reviews
  scope "/", Confer do
    pipe_through [:browser, :auth_professor]
    resources "/reviews", ReviewController # Professor CRUD review
  end

  # Backend Admin Role: God View and Reviews
  scope "/backend", Confer do
    pipe_through [:browser, :backend_layout, :auth_admin] # protected
    get "/", BackendController, :index
    get "/reviews", BackendController, :index_reviews
  end

  scope "/backend/admin", ExAdmin do
    pipe_through [:browser, :auth_admin]
    admin_routes
  end

  # Swoosh mailbox
  if Mix.env == :dev do
    scope "/backend" do
      pipe_through [:browser, :auth_admin]
      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/backend/mailbox"]
    end
  end



end

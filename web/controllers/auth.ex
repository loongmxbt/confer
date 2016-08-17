defmodule Confer.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Confer.Router.Helpers
  alias Confer.Role
  alias Confer.Repo

  def auth_role(conn, auth_role) do
    current_user = conn.assigns.current_user

    if current_user do
      user_role = Repo.get(Role, current_user.role_id).name
      if user_role == auth_role do
        conn
      end
    else
      conn
      |> put_flash(:error, "You must have the right role!")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

end

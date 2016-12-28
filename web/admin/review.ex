defmodule Confer.ExAdmin.Review do
  use ExAdmin.Register
  alias Confer.{Repo, Paper, User, Status}

  register_resource Confer.Review do
    menu priority: 32, label: "评阅"

    form review do
      inputs do
        input review, :paper, collection: Repo.all(Paper)
        input review, :user, collection: Repo.all(from u in User, where: u.role_id == 2)
        input review, :status, collection: Repo.all(Status)
        input review, :content
      end
    end

  end

  # form profs

end

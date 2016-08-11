defmodule Confer.ExAdmin.User do
  use ExAdmin.Register

  register_resource Confer.User do
    menu priority: 41, label: "用户"
  end
end

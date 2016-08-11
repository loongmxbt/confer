defmodule Confer.ExAdmin.Role do
  use ExAdmin.Register

  register_resource Confer.Role do
    menu priority: 42, label: "角色"
  end
end

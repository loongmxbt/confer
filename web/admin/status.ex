defmodule Confer.ExAdmin.Status do
  use ExAdmin.Register

  register_resource Confer.Status do
    menu priority: 34, label: "状态"
  end
end

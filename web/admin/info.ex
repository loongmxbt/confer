defmodule Confer.ExAdmin.Info do
  use ExAdmin.Register

  register_resource Confer.Info do
    menu priority: 22, label: "信息"
  end
end

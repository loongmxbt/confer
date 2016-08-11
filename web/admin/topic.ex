defmodule Confer.ExAdmin.Topic do
  use ExAdmin.Register

  register_resource Confer.Topic do
    menu priority: 33, label: "主题"
  end
end

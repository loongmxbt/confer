defmodule Confer.ExAdmin.Review do
  use ExAdmin.Register

  register_resource Confer.Review do
    menu priority: 32, label: "评阅"
  end
end

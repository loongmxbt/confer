defmodule Confer.ExAdmin.Post do
  use ExAdmin.Register

  register_resource Confer.Post do
    index do
      selectable_column

      column :id
      column :title
      actions
    end

    form post do
      inputs do
        input post, :title
        input post, :content, type: :text
      end
    end
  end
end

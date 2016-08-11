defmodule Confer.ExAdmin.Page do
  use ExAdmin.Register

  register_resource Confer.Page do
    menu priority: 21, label: "页面"

    index do
      selectable_column

      column :id
      column :title
      column :slug
      actions
    end

    form page do
      inputs do
        input page, :title
        input page, :slug
        input page, :content, type: :text
      end
    end
  end
end

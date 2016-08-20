defmodule Confer.ExAdmin.Paper do
  use ExAdmin.Register
  alias Confer.Repo
  alias Confer.Topic
  alias Confer.User

  register_resource Confer.Paper do
    menu priority: 31, label: "论文"

    index do
      selectable_column

      column :id
      column :title
      column :topic
      column :user, fields: [:name]
      actions
    end

    form paper do
      inputs do
        input paper, :title
        input paper, :topic, collection: Repo.all(Topic)
      end

      # inputs "Reviews" do
      #   has_many paper, :reviews, fn(r) ->
      #     input r, :content
      #   end
      # end
    end

    show paper do
      attributes_table do
        row :id
        row :title
        row :filename
        row :content_type
        row :topic
        row :user
        # row :file, [], &(Exfile.Phoenix.Helpers.exfile_path(&1))
        # TODO exfile
      end

      panel "Reviews" do
        table_for(paper.reviews) do
          column "Status", fn(review) ->
            "#{review.status.name}"
          end
          column "Professor", fn(review) ->
            "#{review.user.name}"
          end
          column "Content", fn(review) ->
            "#{review.content}"
          end
        end
      end

    end

    query do
      %{
        all: [preload: [:topic, :user, reviews: [:status, :user]]]
      }
    end

  end
end

defmodule Confer.ExAdmin.Paper do
  use ExAdmin.Register
  alias Confer.{Repo, Topic, User, Paper, Review}
  import Exfile.Phoenix.Helpers

  member_action :assign_paper,  &__MODULE__.assign_paper_reviews/2
  member_action :send_paper,  &__MODULE__.send_paper_to_profs/2

  register_resource Confer.Paper do
    menu priority: 31, label: "论文"

    index do
      selectable_column

      column :id
      column :title
      column :topic
      column :author
      column :unit
      column :postcode
      column :phone
      column :email
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
        # Here &1 represents the paper, so we need to use &1.file
        # https://github.com/smpallen99/ex_admin/issues/199
        # https://github.com/keichan34/exfile/blob/7441e1b35728b9c27f486ccf023ba327ca0f5d73/test/exfile/phoenix/helpers_test.exs
        row :file_path, &(exfile_path(&1.file))
        row :file_url, &(exfile_url(conn, &1.file, filename: "PID#{&1.id}-CID#{&1.topic.id}"))

      end


      panel "Reviews" do
        table_for(paper.reviews) do
          column "Id", fn(review) ->
            a "#{review.id}", href: "/backend/admin/reviews/#{review.id}"
          end
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


  def assign_paper_reviews(conn, params) do
    paper = Repo.get(Paper, params[:id])
    topic_id = paper.topic_id
    # 已有review
    query = from r in Review, select: r.user_id, where: r.paper_id == ^paper.id
    rev_prof_ids = Repo.all(query)
    rev_num = rev_prof_ids |> Enum.count
    # 总共需要review
    rev_total = 3

    # prof_num = rev_total - rev_num
    #
    # prof_num = if prof_num < 0 do
    #   0
    # end

    prof_num = cond do
      rev_total - rev_num < 0 -> 0
      true -> rev_total - rev_num
    end
    # 分配 review_total - review_num 的 reviews
    query = from u in User, select: u.id, where: u.role_id == 2 and u.topic_id == ^topic_id
    # 需要选择没有的profs
    all_prof_ids = Repo.all(query) # prof_id list

    # prof_ids = Enum.shuffle(all_prof_ids -- rev_prof_ids)
    prof_ids = Enum.take_random(all_prof_ids -- rev_prof_ids, prof_num)


    for prof_id <- prof_ids do
      Review.changeset(%Review{}, %{status_id: 1, paper_id: paper.id, user_id: prof_id})
      |> Repo.insert!
    end

    conn
    |> Phoenix.Controller.redirect(to: "/backend/admin/papers/#{params[:id]}")

  end


  def send_paper_to_profs(conn, params) do
    conn
    # |> Phoenix.Controller.put_flash(:info, "Paper send")
    |> Phoenix.Controller.redirect(to: "/backend/admin/papers/#{params[:id]}")
  end

end

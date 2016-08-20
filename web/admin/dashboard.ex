defmodule Confer.ExAdmin.Dashboard do
  use ExAdmin.Register
  alias Confer.{Repo, User, Page, Post, Paper, Topic}

  register_page "Dashboard" do
    menu priority: 1, label: "导航"
    content do
      columns do
        column do
          panel "管理员" do
            query = from u in User, where: u.role_id == 3
            Repo.all(query)
            |> table_for do
              column "Name", fn(u) -> a u.name, href: "/backend/admin/users/#{u.id}" end
              column "Email", fn(u) -> u.email end
            end
          end
        end
        column do
          panel "教授" do
            query = from u in User, where: u.role_id == 2
            Repo.all(query)
            |> table_for do
              column "Name", fn(u) -> a u.name, href: "/backend/admin/users/#{u.id}" end
              column "Email", fn(u) -> u.email end
            end
          end
        end
        column do
          panel "用户统计" do
            markup_contents do
              # TODO: simplify
              query = from u in User, select: [:id], where: u.role_id == 1
              user_num = Repo.all(query) |> Enum.count
              query = from u in User, select: [:id], where: u.role_id == 2
              prof_num = Repo.all(query) |> Enum.count
              query = from u in User, select: [:id], where: u.role_id == 3
              admin_num = Repo.all(query) |> Enum.count
              table ".table" do
                thead do
                  th "用户类型"
                  th "数量"
                end
                tbody do
                  tr do
                    td "普通用户"
                    td "#{user_num}"
                  end
                  tr do
                    td "教授用户"
                    td "#{prof_num}"
                  end
                  tr do
                    td "管理员用户"
                    td "#{admin_num}"
                  end
                end
              end
            end
          end
        end
      end
      columns do
        column do
          panel "页面" do
            query = from p in Page, select: [:id, :title, :slug]
            Repo.all(query)
            |> table_for do
              column "Title", fn(p) -> a p.title, href: "/backend/admin/pages/#{p.id}" end
              column "Slug", fn(p) -> p.slug end
            end
          end
        end
        column do
          panel "通知" do
            query = from p in Post, select: [:id, :title, :inserted_at]
            Repo.all(query)
            |> table_for do
              column "Title", fn(p) -> a p.title, href: "/backend/admin/posts/#{p.id}" end
              column "Time", fn(p) -> "#{p.inserted_at}" end
            end
          end
        end
        column do
          panel "论文统计" do
            markup_contents do
              # TODO: simplify
              query = from p in Paper, select: [:id], where: p.topic_id == 1
              num1 = Repo.all(query) |> Enum.count
              topic1 = Repo.get(Topic, 1).name
              query = from p in Paper, select: [:id], where: p.topic_id == 2
              num2 = Repo.all(query) |> Enum.count
              topic2 = Repo.get(Topic, 2).name
              query = from p in Paper, select: [:id], where: p.topic_id == 3
              num3 = Repo.all(query) |> Enum.count
              topic3 = Repo.get(Topic, 3).name
              query = from p in Paper, select: [:id], where: p.topic_id == 4
              num4 = Repo.all(query) |> Enum.count
              topic4 = Repo.get(Topic, 4).name
              query = from p in Paper, select: [:id], where: p.topic_id == 5
              num5 = Repo.all(query) |> Enum.count
              topic5 = Repo.get(Topic, 5).name
              table ".table" do
                thead do
                  th "主题"
                  th "数量"
                end
                tbody do
                  tr do
                    td "#{topic1}"
                    td "#{num1}"
                  end
                  tr do
                    td "#{topic2}"
                    td "#{num2}"
                  end
                  tr do
                    td "#{topic3}"
                    td "#{num3}"
                  end
                  tr do
                    td "#{topic4}"
                    td "#{num4}"
                  end
                  tr do
                    td "#{topic5}"
                    td "#{num5}"
                  end
                end

              end

            end


          end
        end
      end
    end
  end
end

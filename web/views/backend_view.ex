defmodule Confer.BackendView do
  use Confer.Web, :view

  def status_name(id) do
    case id do
      1 -> "等待评阅"
      2 -> "评阅通过"
      3 -> "评阅拒绝"
      _ -> "尚未分配"
    end
  end

end

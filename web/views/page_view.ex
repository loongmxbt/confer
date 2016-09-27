defmodule Confer.PageView do
  use Confer.Web, :view
  alias Confer.{Repo, Info}
  import Ecto.Query

  def format_date(date_time) do
    date_str = Ecto.DateTime.to_string(date_time)
    [ymd, _] = String.split(date_str)
    ymd
  end

  # infos["wechat"]
  # def infos do
  #   query = from i in Info,
  #           select: {i.slug, i.content}
  #   infos = Repo.all(query) |> Enum.into(%{})
  # end

  # get_info("wechat")
  def get_info(slug) do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> "#{slug}未定义"
      _   -> info.content
    end
  end


end

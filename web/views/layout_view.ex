defmodule Confer.LayoutView do
  use Confer.Web, :view
  alias Confer.{Repo, Info}

  def get_info(slug) do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> "#{slug}未定义"
      _   -> info.content
    end
  end

  def get_info(slug, "name") do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> "#{slug}未定义"
      _   -> info.name
    end
  end

end

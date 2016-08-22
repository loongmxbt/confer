defmodule Confer.LayoutView do
  use Confer.Web, :view
  alias Confer.{Repo, Info}

  def get_info(slug) do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> "#{slug}"
      _   -> info.content
    end
  end

end

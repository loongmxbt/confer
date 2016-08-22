defmodule Confer.LayoutView do
  use Confer.Web, :view
  alias Confer.{Repo, Info}

  def header_h1 do
    Repo.get_by(Info, slug: "header_h1").content
  end

  def header_h2 do
    Repo.get_by(Info, slug: "header_h2").content
  end

  def header_logo do
    Repo.get_by(Info, slug: "header_logo").content
  end

end

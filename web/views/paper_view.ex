defmodule Confer.PaperView do
  use Confer.Web, :view
  alias Confer.{Repo, Info}
  import Ecto.Query

  @doc """
  In paper show.html.eex
  full_filename(paper)
  """

  def full_filename(paper) do
    title = "PID#{paper.id}-CID#{paper.topic_id}"
    ext = paper.content_type

    filename = case ext do
      "application/pdf" -> title <> ".pdf"
      "application/msword" -> title <> ".doc"
      "application/zip" -> title <> ".docx"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" -> title <> ".docx"
      _ -> title
    end
  end

  # def full_filename(pid, tid, ext) do
  #   title = "PID#{pid}-CID#{tid}"
  #   filename = case ext do
  #     "application/pdf" -> title <> ".pdf"
  #     "application/msword" -> title <> ".doc"
  #     "application/zip" -> title <> ".docx"
  #     "application/vnd.openxmlformats-officedocument.wordprocessingml.document" -> title <> ".docx"
  #     _ -> title
  #   end
  # end

  def review_label(status_id) do
    case status_id do
      1 -> "<span class=\"label label-primary\"> 等待评阅 </span>"
      2 -> "<span class=\"label label-success\"> 评阅通过 </span>"
      3 -> "<span class=\"label label-danger\"> 评阅拒绝 </span>"
      _ -> "<span class=\"label label-primary\"> 等待评阅 </span>"
    end
  end

  def get_info(slug) do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> "#{slug}未定义"
      _   -> info.content
    end
  end

  def get_info(slug, default) do
    info = Repo.get_by(Info, slug: slug)
    case info do
      nil -> default
      _   -> info.content
    end
  end

  def paper_type do
    paper_type = case Repo.get_by(Info, slug: "paper_type").content do
      "初稿" -> "初稿"
      "终稿" -> "终稿"
      _     -> "暂停投稿"
    end
  end


end

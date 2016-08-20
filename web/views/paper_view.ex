defmodule Confer.PaperView do
  use Confer.Web, :view

  def full_name_ext(title, ext) do
    case ext do
      "application/pdf" -> title <> ".pdf"
      "application/msword" -> title <> ".doc"
      "application/zip" -> title <> ".docx"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" -> title <> ".docx"
      _ -> title
    end
  end

  def review_label(status_id) do
    case status_id do
      1 -> "<span class=\"label label-primary\"> 等待评阅 </span>"
      2 -> "<span class=\"label label-success\"> 评阅通过 </span>"
      3 -> "<span class=\"label label-danger\"> 评阅拒绝 </span>"
      _ -> "<span class=\"label label-primary\"> 等待评阅 </span>"
    end
  end


end

defmodule Confer.PostView do
  use Confer.Web, :view

  def format_date(date_time) do
    date_str = Ecto.DateTime.to_string(date_time)
    [ymd, _] = String.split(date_str)
    ymd
  end
  
end

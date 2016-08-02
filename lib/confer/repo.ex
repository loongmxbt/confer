defmodule Confer.Repo do
  use Ecto.Repo, otp_app: :confer
  use Scrivener, page_size: 10
end

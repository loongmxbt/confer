defmodule Confer.Paper do
  use Confer.Web, :model

  import Exfile.Ecto.ValidateContentType
  import Exfile.Ecto.CastContentType
  import Exfile.Ecto.CastFilename

  schema "papers" do
    field :title, :string
    field :author, :string
    field :keyword, :string
    field :unit, :string
    field :postcode, :string
    field :phone, :string
    field :email, :string
    field :file, Exfile.Ecto.File
    field :content_type, :string
    field :filename, :string
    belongs_to :topic, Confer.Topic
    belongs_to :user, Confer.User
    belongs_to :status, Confer.Status
    has_many :reviews, Confer.Review

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :file, :topic_id, :user_id, :content_type, :filename, :author, :keyword, :unit, :postcode, :phone, :email, :status_id])
    |> validate_required([:title, :topic_id, :file, :user_id, :author, :keyword, :unit, :postcode, :phone, :email])
    |> validate_content_type(:file, ~w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/zip))
    |> cast_content_type(:file, :content_type)
    |> cast_filename(:file, :filename) # BUG: filename can't be chinese, file ext
    |> cast_authors
    |> Exfile.Ecto.prepare_uploads([:file])
  end

  defp cast_authors(changeset) do
    author_str = get_field(changeset, :author)
    |> to_string
    |> String.replace(",", ";")
    Ecto.Changeset.put_change(changeset, :author, author_str)
  end

  defp cast_keywords(changeset) do
    keyword_str = get_field(changeset, :keyword)
    |> to_string
    |> String.replace(",", ";")
    Ecto.Changeset.put_change(changeset, :keyword, keyword_str)
  end

end

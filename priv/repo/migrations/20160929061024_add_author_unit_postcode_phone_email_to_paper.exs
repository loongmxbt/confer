defmodule Confer.Repo.Migrations.AddAuthorUnitPostcodePhoneEmailToPaper do
  use Ecto.Migration

  def change do
    alter table(:papers) do
      add :author, :string
      add :unit, :string
      add :postcode, :string
      add :phone, :string
      add :email, :string
    end
  end
end

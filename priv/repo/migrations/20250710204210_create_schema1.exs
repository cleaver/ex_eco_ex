defmodule Ecoexpense.Repo.Migrations.CreateSchema1 do
  use Ecto.Migration

  def change do
    create table(:schema1) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end

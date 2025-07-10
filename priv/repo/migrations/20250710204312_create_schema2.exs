defmodule Ecoexpense.Repo.Migrations.CreateSchema2 do
  use Ecto.Migration

  def change do
    create table(:schema2) do
      add :name, :string
      add :parent, references(:schema1, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:schema2, [:parent])
  end
end

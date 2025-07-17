defmodule Ecoexpense.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :desc, :string

      timestamps(type: :utc_datetime)
    end
  end
end

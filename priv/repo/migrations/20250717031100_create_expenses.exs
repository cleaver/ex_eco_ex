defmodule Ecoexpense.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :desc, :string

      timestamps(type: :utc_datetime)
    end
  end
end

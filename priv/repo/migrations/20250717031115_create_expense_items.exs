defmodule Ecoexpense.Repo.Migrations.CreateExpenseItems do
  use Ecto.Migration

  def change do
    create table(:expense_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :detail, :string
      add :amount, :string
      add :expense_id, references(:expenses, type: :uuid, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:expense_items, [:expense_id])
  end
end

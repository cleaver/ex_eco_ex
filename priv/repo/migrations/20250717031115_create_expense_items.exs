defmodule Ecoexpense.Repo.Migrations.CreateExpenseItems do
  use Ecto.Migration

  def change do
    create table(:expense_items) do
      add :detail, :string
      add :amount, :string
      add :expense_id, references(:expenses, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:expense_items, [:expense_id])
  end
end

defmodule Ecoexpense.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "expenses" do
    field :desc, :string
    has_many :expense_items, Ecoexpense.Expenses.ExpenseItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
  end
end

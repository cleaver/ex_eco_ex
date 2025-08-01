defmodule Ecoexpense.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecoexpense.Expenses.ExpenseItem

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
    |> cast_assoc(:expense_items, with: &ExpenseItem.changeset/2)
    |> validate_required([:desc])
  end
end

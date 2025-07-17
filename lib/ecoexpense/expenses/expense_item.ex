defmodule Ecoexpense.Expenses.ExpenseItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "expense_items" do
    field :detail, :string
    field :amount, :string
    belongs_to :expense, Ecoexpense.Expenses.Expense, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense_item, attrs) do
    expense_item
    |> cast(attrs, [:detail, :amount, :expense_id])
    |> cast_assoc(:expense)
    |> validate_required([:detail, :amount])
  end
end

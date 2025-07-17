defmodule Ecoexpense.Expenses.ExpenseItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expense_items" do
    field :detail, :string
    field :amount, :string
    field :expense_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense_item, attrs) do
    expense_item
    |> cast(attrs, [:detail, :amount])
    |> validate_required([:detail, :amount])
  end
end

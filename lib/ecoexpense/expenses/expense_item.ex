defmodule Ecoexpense.Expenses.ExpenseItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "expense_items" do
    field :detail, :string
    field :amount, :string
    field :delete, :boolean, virtual: true
    field :temp_id, :string, virtual: true
    belongs_to :expense, Ecoexpense.Expenses.Expense, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense_item, attrs) do
    expense_item
    |> Map.put(:temp_id, expense_item.temp_id || attrs["temp_id"])
    |> cast(attrs, [:detail, :amount, :expense_id, :delete, :temp_id])
    |> cast_assoc(:expense)
    |> validate_required([:detail, :amount])
    |> maybe_mark_for_deletion()
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset

  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end

defmodule Ecoexpense.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecoexpense.Expenses` context.
  """

  alias Ecoexpense.Repo

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        desc: "some desc"
      })
      |> Ecoexpense.Expenses.create_expense()

    expense |> Repo.preload(:expense_items)
  end

  @doc """
  Generate a expense_item.
  """
  def expense_item_fixture(attrs \\ %{}) do
    expense = expense_fixture()

    {:ok, expense_item} =
      attrs
      |> Enum.into(%{
        detail: "some detail",
        amount: "10.50",
        expense_id: expense.id
      })
      |> Ecoexpense.Expenses.create_expense_item()

    expense_item
  end
end

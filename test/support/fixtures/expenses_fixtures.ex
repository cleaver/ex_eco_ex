defmodule Ecoexpense.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecoexpense.Expenses` context.
  """

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

    expense
  end
end

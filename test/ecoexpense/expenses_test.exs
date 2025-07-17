defmodule Ecoexpense.ExpensesTest do
  use Ecoexpense.DataCase
  use Machete

  alias Ecoexpense.Expenses

  describe "expenses" do
    alias Ecoexpense.Expenses.Expense

    import Ecoexpense.ExpensesFixtures

    @invalid_attrs %{desc: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture() |> Repo.preload(:expense_items)
      assert Expenses.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Expenses.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{desc: "some desc"}

      assert {:ok, %Expense{} = expense} = Expenses.create_expense(valid_attrs)
      assert expense.desc == "some desc"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{desc: "some updated desc"}

      assert {:ok, %Expense{} = expense} = Expenses.update_expense(expense, update_attrs)
      assert expense.desc == "some updated desc"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_expense(expense, @invalid_attrs)
      assert expense == Expenses.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Expenses.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Expenses.change_expense(expense)
    end
  end

  describe "expense_items" do
    alias Ecoexpense.Expenses.ExpenseItem

    import Ecoexpense.ExpensesFixtures

    @invalid_expense_item_attrs %{detail: nil, amount: nil}

    test "list_expense_items/1 returns all expense items for an expense" do
      expense = expense_fixture()

      expense_item =
        expense_item_fixture(%{expense_id: expense.id})
        |> Repo.preload(:expense)

      expense_item_from_list =
        Expenses.list_expense_items(expense.id)
        |> hd()

      assert expense_item_from_list == expense_item
    end

    test "create_expense_item/1 with valid data creates an expense item" do
      expense = expense_fixture()
      valid_attrs = %{detail: "some detail", amount: "10.50", expense_id: expense.id}

      assert {:ok, %ExpenseItem{} = expense_item} = Expenses.create_expense_item(valid_attrs)
      assert expense_item.detail == "some detail"
      assert expense_item.amount == "10.50"
      assert expense_item.expense_id == expense.id
    end

    test "create_expense_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Expenses.create_expense_item(@invalid_expense_item_attrs)
    end

    test "get_expense_item!/2 returns the expense item with given id for the expense" do
      expense = expense_fixture()
      expense_item = expense_item_fixture(%{expense_id: expense.id})
      assert Expenses.get_expense_item!(expense, expense_item.id) == expense_item
    end

    test "get_expense_item!/2 with wrong expense returns error" do
      expense1 = expense_fixture()
      expense2 = expense_fixture()
      expense_item = expense_item_fixture(%{expense_id: expense1.id})

      assert_raise Ecto.NoResultsError, fn ->
        Expenses.get_expense_item!(expense2, expense_item.id)
      end
    end

    test "update_expense_item/2 with valid data updates the expense item" do
      expense = expense_fixture()
      expense_item = expense_item_fixture(%{expense_id: expense.id})
      update_attrs = %{detail: "some updated detail", amount: "25.75"}

      assert {:ok, %ExpenseItem{} = updated_expense_item} =
               Expenses.update_expense_item(expense_item, update_attrs)

      assert updated_expense_item.detail == "some updated detail"
      assert updated_expense_item.amount == "25.75"
    end

    test "update_expense_item/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      expense_item = expense_item_fixture(%{expense_id: expense.id})

      assert {:error, %Ecto.Changeset{}} =
               Expenses.update_expense_item(expense_item, @invalid_expense_item_attrs)

      # Verify the expense item wasn't changed
      unchanged_expense_item = Expenses.get_expense_item!(expense, expense_item.id)
      assert unchanged_expense_item.detail == expense_item.detail
      assert unchanged_expense_item.amount == expense_item.amount
    end
  end
end

defmodule EcoexpenseWeb.ExpenseLiveTest do
  use EcoexpenseWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ecoexpense.ExpensesFixtures

  @create_attrs %{desc: "some desc"}
  @update_attrs %{desc: "some updated desc"}
  @invalid_attrs %{desc: nil}
  defp create_expense(_) do
    expense = expense_fixture()

    %{expense: expense}
  end

  describe "Index" do
    setup [:create_expense]

    test "lists all expenses", %{conn: conn, expense: expense} do
      {:ok, _index_live, html} = live(conn, ~p"/expenses")

      assert html =~ "Listing Expenses"
      assert html =~ expense.desc
    end

    test "saves new expense", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/expenses")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Expense")
               |> render_click()
               |> follow_redirect(conn, ~p"/expenses/new")

      assert has_element?(form_live, "h1", "New Expense")

      assert form_live
             |> form("#expense-form", expense: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#expense-form", expense: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/expenses")

      # tried using assert_redirect(ed) to test the flash message, to no avail
      assert has_element?(index_live, "#flash-info>>>p", "Expense created successfully")

      assert has_element?(index_live, "tbody#expenses>tr>td", "some desc")
    end

    test "updates expense in listing", %{conn: conn, expense: expense} do
      {:ok, index_live, _html} = live(conn, ~p"/expenses")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#expenses-#{expense.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/expenses/#{expense}/edit")

      assert render(form_live) =~ "Edit Expense"

      assert form_live
             |> form("#expense-form", expense: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#expense-form", expense: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/expenses")

      html = render(index_live)
      assert html =~ "Expense updated successfully"
      assert html =~ "some updated desc"
    end

    test "deletes expense in listing", %{conn: conn, expense: expense} do
      {:ok, index_live, _html} = live(conn, ~p"/expenses")

      assert index_live |> element("#expenses-#{expense.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#expenses-#{expense.id}")
    end
  end

  describe "Show" do
    setup [:create_expense]

    test "displays expense", %{conn: conn, expense: expense} do
      {:ok, _show_live, html} = live(conn, ~p"/expenses/#{expense}")

      assert html =~ "Show Expense"
      assert html =~ expense.desc
    end

    test "updates expense and returns to show", %{conn: conn, expense: expense} do
      {:ok, show_live, _html} = live(conn, ~p"/expenses/#{expense}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/expenses/#{expense}/edit?return_to=show")

      assert render(form_live) =~ "Edit Expense"

      assert form_live
             |> form("#expense-form", expense: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#expense-form", expense: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/expenses/#{expense}")

      html = render(show_live)
      assert html =~ "Expense updated successfully"
      assert html =~ "some updated desc"
    end
  end
end

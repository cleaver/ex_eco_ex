defmodule EcoexpenseWeb.ExpenseLive.Show do
  use EcoexpenseWeb, :live_view

  alias Ecoexpense.Expenses

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Expense {@expense.desc}
        <:subtitle>This is a expense record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/expenses"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/expenses/#{@expense}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit expense
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Desc">{@expense.desc}</:item>
        <:item title="Items">
          <.table id="expense-items" rows={@expense.expense_items}>
            <:col :let={item}>{item.detail}</:col>
            <:col :let={item}>{item.amount}</:col>
          </.table>
        </:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Expense")
     |> assign(:expense, Expenses.get_expense!(id))}
  end
end

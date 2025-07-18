defmodule EcoexpenseWeb.ExpenseLive.Form do
  use EcoexpenseWeb, :live_view

  alias Ecoexpense.Expenses
  alias Ecoexpense.Expenses.Expense

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage expense records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="expense-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:desc]} type="text" label="Desc" />
        <div :if={@live_action == :edit}>
          <h3>Details</h3>
          <.inputs_for :let={f_nested} field={@form[:expense_items]}>
            <div class="flex gap-2">
              <.input field={f_nested[:detail]} type="text" label="Detail" />
              <.input field={f_nested[:amount]} type="text" label="Amount" />
              <.input field={f_nested[:delete]} type="checkbox" label="Delete" />
            </div>
          </.inputs_for>
        </div>
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Expense</.button>
          <.button navigate={return_path(@return_to, @expense)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    expense = Expenses.get_expense!(id)

    socket
    |> assign(:page_title, "Edit Expense")
    |> assign(:expense, expense)
    |> assign(:form, to_form(Expenses.change_expense(expense)))
  end

  defp apply_action(socket, :new, _params) do
    expense = %Expense{}

    socket
    |> assign(:page_title, "New Expense")
    |> assign(:expense, expense)
    |> assign(:form, to_form(Expenses.change_expense(expense)))
  end

  @impl true
  def handle_event("validate", %{"expense" => expense_params}, socket) do
    IO.inspect(expense_params, label: "expense_params")
    changeset = Expenses.change_expense(socket.assigns.expense, expense_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"expense" => expense_params}, socket) do
    save_expense(socket, socket.assigns.live_action, expense_params)
  end

  defp save_expense(socket, :edit, expense_params) do
    case Expenses.update_expense(socket.assigns.expense, expense_params) do
      {:ok, expense} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expense updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, expense))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_expense(socket, :new, expense_params) do
    case Expenses.create_expense(expense_params) do
      {:ok, expense} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expense created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, expense))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _expense), do: ~p"/expenses"
  defp return_path("show", expense), do: ~p"/expenses/#{expense}"
end

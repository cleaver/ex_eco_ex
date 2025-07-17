defmodule Ecoexpense.Expenses do
  @moduledoc """
  The Expenses context.
  """

  import Ecto.Query, warn: false
  alias Ecoexpense.Repo

  alias Ecoexpense.Expenses.Expense
  alias Ecoexpense.Expenses.ExpenseItem

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """
  def list_expenses do
    from(e in Expense, order_by: [desc: :inserted_at], preload: :expense_items)
    |> Repo.all()
  end

  @doc """
  Gets a single expense, preloaded with expense items.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id) do
    Expense
    |> Repo.get!(id)
    |> Repo.preload(:expense_items)
  end

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(attrs) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{data: %Expense{}}

  """
  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end

  def list_expense_items(expense_id) do
    from(e in ExpenseItem,
      where: e.expense_id == ^expense_id,
      order_by: [desc: :inserted_at],
      preload: :expense
    )
    |> Repo.all()
  end

  def create_expense_item(attrs) do
    %ExpenseItem{}
    |> ExpenseItem.changeset(attrs)
    |> Repo.insert()
  end

  def get_expense_item!(expense, id) do
    ExpenseItem
    |> Repo.get_by!(expense_id: expense.id, id: id)
  end
end

defmodule Ecoexpense.ContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ecoexpense.Context` context.
  """

  @doc """
  Generate a schema1.
  """
  def schema1_fixture(attrs \\ %{}) do
    {:ok, schema1} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ecoexpense.Context.create_schema1()

    schema1
  end

  @doc """
  Generate a schema2.
  """
  def schema2_fixture(attrs \\ %{}) do
    {:ok, schema2} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ecoexpense.Context.create_schema2()

    schema2
  end
end

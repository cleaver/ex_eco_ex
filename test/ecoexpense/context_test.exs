defmodule Ecoexpense.ContextTest do
  use Ecoexpense.DataCase

  alias Ecoexpense.Context

  describe "schema1" do
    alias Ecoexpense.Context.Schema1

    import Ecoexpense.ContextFixtures

    @invalid_attrs %{name: nil}

    test "list_schema1/0 returns all schema1" do
      schema1 = schema1_fixture()
      assert Context.list_schema1() == [schema1]
    end

    test "get_schema1!/1 returns the schema1 with given id" do
      schema1 = schema1_fixture()
      assert Context.get_schema1!(schema1.id) == schema1
    end

    test "create_schema1/1 with valid data creates a schema1" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Schema1{} = schema1} = Context.create_schema1(valid_attrs)
      assert schema1.name == "some name"
    end

    test "create_schema1/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Context.create_schema1(@invalid_attrs)
    end

    test "update_schema1/2 with valid data updates the schema1" do
      schema1 = schema1_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Schema1{} = schema1} = Context.update_schema1(schema1, update_attrs)
      assert schema1.name == "some updated name"
    end

    test "update_schema1/2 with invalid data returns error changeset" do
      schema1 = schema1_fixture()
      assert {:error, %Ecto.Changeset{}} = Context.update_schema1(schema1, @invalid_attrs)
      assert schema1 == Context.get_schema1!(schema1.id)
    end

    test "delete_schema1/1 deletes the schema1" do
      schema1 = schema1_fixture()
      assert {:ok, %Schema1{}} = Context.delete_schema1(schema1)
      assert_raise Ecto.NoResultsError, fn -> Context.get_schema1!(schema1.id) end
    end

    test "change_schema1/1 returns a schema1 changeset" do
      schema1 = schema1_fixture()
      assert %Ecto.Changeset{} = Context.change_schema1(schema1)
    end
  end

  describe "schema2" do
    alias Ecoexpense.Context.Schema2

    import Ecoexpense.ContextFixtures

    @invalid_attrs %{name: nil}

    test "list_schema2/0 returns all schema2" do
      schema2 = schema2_fixture()
      assert Context.list_schema2() == [schema2]
    end

    test "get_schema2!/1 returns the schema2 with given id" do
      schema2 = schema2_fixture()
      assert Context.get_schema2!(schema2.id) == schema2
    end

    test "create_schema2/1 with valid data creates a schema2" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Schema2{} = schema2} = Context.create_schema2(valid_attrs)
      assert schema2.name == "some name"
    end

    test "create_schema2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Context.create_schema2(@invalid_attrs)
    end

    test "update_schema2/2 with valid data updates the schema2" do
      schema2 = schema2_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Schema2{} = schema2} = Context.update_schema2(schema2, update_attrs)
      assert schema2.name == "some updated name"
    end

    test "update_schema2/2 with invalid data returns error changeset" do
      schema2 = schema2_fixture()
      assert {:error, %Ecto.Changeset{}} = Context.update_schema2(schema2, @invalid_attrs)
      assert schema2 == Context.get_schema2!(schema2.id)
    end

    test "delete_schema2/1 deletes the schema2" do
      schema2 = schema2_fixture()
      assert {:ok, %Schema2{}} = Context.delete_schema2(schema2)
      assert_raise Ecto.NoResultsError, fn -> Context.get_schema2!(schema2.id) end
    end

    test "change_schema2/1 returns a schema2 changeset" do
      schema2 = schema2_fixture()
      assert %Ecto.Changeset{} = Context.change_schema2(schema2)
    end
  end
end

defmodule EcoexpenseWeb.Schema1LiveTest do
  use EcoexpenseWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ecoexpense.ContextFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_schema1(_) do
    schema1 = schema1_fixture()

    %{schema1: schema1}
  end

  describe "Index" do
    setup [:create_schema1]

    test "lists all schema1", %{conn: conn, schema1: schema1} do
      {:ok, _index_live, html} = live(conn, ~p"/schema1")

      assert html =~ "Listing Schema1"
      assert html =~ schema1.name
    end

    test "saves new schema1", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/schema1")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Schema1")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema1/new")

      assert render(form_live) =~ "New Schema1"

      assert form_live
             |> form("#schema1-form", schema1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#schema1-form", schema1: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema1")

      html = render(index_live)
      assert html =~ "Schema1 created successfully"
      assert html =~ "some name"
    end

    test "updates schema1 in listing", %{conn: conn, schema1: schema1} do
      {:ok, index_live, _html} = live(conn, ~p"/schema1")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#schema1-#{schema1.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema1/#{schema1}/edit")

      assert render(form_live) =~ "Edit Schema1"

      assert form_live
             |> form("#schema1-form", schema1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#schema1-form", schema1: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema1")

      html = render(index_live)
      assert html =~ "Schema1 updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes schema1 in listing", %{conn: conn, schema1: schema1} do
      {:ok, index_live, _html} = live(conn, ~p"/schema1")

      assert index_live |> element("#schema1-#{schema1.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#schema1-#{schema1.id}")
    end
  end

  describe "Show" do
    setup [:create_schema1]

    test "displays schema1", %{conn: conn, schema1: schema1} do
      {:ok, _show_live, html} = live(conn, ~p"/schema1/#{schema1}")

      assert html =~ "Show Schema1"
      assert html =~ schema1.name
    end

    test "updates schema1 and returns to show", %{conn: conn, schema1: schema1} do
      {:ok, show_live, _html} = live(conn, ~p"/schema1/#{schema1}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema1/#{schema1}/edit?return_to=show")

      assert render(form_live) =~ "Edit Schema1"

      assert form_live
             |> form("#schema1-form", schema1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#schema1-form", schema1: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema1/#{schema1}")

      html = render(show_live)
      assert html =~ "Schema1 updated successfully"
      assert html =~ "some updated name"
    end
  end
end

defmodule EcoexpenseWeb.Schema2LiveTest do
  use EcoexpenseWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ecoexpense.ContextFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_schema2(_) do
    schema2 = schema2_fixture()

    %{schema2: schema2}
  end

  describe "Index" do
    setup [:create_schema2]

    test "lists all schema2", %{conn: conn, schema2: schema2} do
      {:ok, _index_live, html} = live(conn, ~p"/schema2")

      assert html =~ "Listing Schema2"
      assert html =~ schema2.name
    end

    test "saves new schema2", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/schema2")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Schema2")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema2/new")

      assert render(form_live) =~ "New Schema2"

      assert form_live
             |> form("#schema2-form", schema2: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#schema2-form", schema2: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema2")

      html = render(index_live)
      assert html =~ "Schema2 created successfully"
      assert html =~ "some name"
    end

    test "updates schema2 in listing", %{conn: conn, schema2: schema2} do
      {:ok, index_live, _html} = live(conn, ~p"/schema2")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#schema2-#{schema2.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema2/#{schema2}/edit")

      assert render(form_live) =~ "Edit Schema2"

      assert form_live
             |> form("#schema2-form", schema2: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#schema2-form", schema2: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema2")

      html = render(index_live)
      assert html =~ "Schema2 updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes schema2 in listing", %{conn: conn, schema2: schema2} do
      {:ok, index_live, _html} = live(conn, ~p"/schema2")

      assert index_live |> element("#schema2-#{schema2.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#schema2-#{schema2.id}")
    end
  end

  describe "Show" do
    setup [:create_schema2]

    test "displays schema2", %{conn: conn, schema2: schema2} do
      {:ok, _show_live, html} = live(conn, ~p"/schema2/#{schema2}")

      assert html =~ "Show Schema2"
      assert html =~ schema2.name
    end

    test "updates schema2 and returns to show", %{conn: conn, schema2: schema2} do
      {:ok, show_live, _html} = live(conn, ~p"/schema2/#{schema2}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/schema2/#{schema2}/edit?return_to=show")

      assert render(form_live) =~ "Edit Schema2"

      assert form_live
             |> form("#schema2-form", schema2: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#schema2-form", schema2: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/schema2/#{schema2}")

      html = render(show_live)
      assert html =~ "Schema2 updated successfully"
      assert html =~ "some updated name"
    end
  end
end

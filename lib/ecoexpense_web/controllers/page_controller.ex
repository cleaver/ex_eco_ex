defmodule EcoexpenseWeb.PageController do
  use EcoexpenseWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

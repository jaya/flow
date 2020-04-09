defmodule FlowWeb.Plugs.RequireAuth do

  import Plug.Conn
  import Phoenix.Controller
  alias FlowWeb.Router.Helpers

  def init(_param) do
  end

  def call(conn, _param) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.user_path(conn, :login))
      |> halt()
    end
  end

end

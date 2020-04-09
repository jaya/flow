defmodule FlowWeb.Plugs.RequireAdmin do

  import Plug.Conn
  import Phoenix.Controller
  alias FlowWeb.Router.Helpers

  def init(_param) do
  end

  def call(conn, _param) do
    if conn.assigns[:user].admin do
      conn
    else
      conn
      |> put_flash(:error, "You need to be a admin")
      |> redirect(to: Helpers.candidate_path(conn, :index))
      |> halt()
    end
  end

end

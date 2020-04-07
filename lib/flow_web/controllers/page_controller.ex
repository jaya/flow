defmodule FlowWeb.PageController do
  use FlowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

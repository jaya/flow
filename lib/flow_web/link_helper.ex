defmodule FlowWeb.LinkHelper do
  def active(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "is-active"
    else
      nil
    end
  end

  def logged?(conn) do
    IO.inspect conn
    conn.assigns[:user] != nil
  end

  def admin?(conn) do
    conn.assigns[:user].admin
  end
end

defmodule FlowWeb.LinkHelper do
  def active(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "is-active"
    else
      nil
    end
  end
end

defmodule FlowWeb.StatusController do
  use FlowWeb, :controller

  alias Flow.Jobs
  alias Flow.Jobs.Status

  plug FlowWeb.Plugs.RequireAuth
  plug FlowWeb.Plugs.RequireAdmin when action in [:index, :new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    status = Jobs.list_status()
    render(conn, "index.html", status: status)
  end

  def new(conn, _params) do
    changeset = Jobs.change_status(%Status{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"status" => status_params}) do
    case Jobs.create_status(status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status created successfully.")
        |> redirect(to: Routes.status_path(conn, :show, status))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    status = Jobs.get_status!(id)
    render(conn, "show.html", status: status)
  end

  def edit(conn, %{"id" => id}) do
    status = Jobs.get_status!(id)
    changeset = Jobs.change_status(status)
    render(conn, "edit.html", status: status, changeset: changeset)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
    status = Jobs.get_status!(id)

    case Jobs.update_status(status, status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status updated successfully.")
        |> redirect(to: Routes.status_path(conn, :show, status))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", status: status, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    status = Jobs.get_status!(id)
    {:ok, _status} = Jobs.delete_status(status)

    conn
    |> put_flash(:info, "Status deleted successfully.")
    |> redirect(to: Routes.status_path(conn, :index))
  end
end

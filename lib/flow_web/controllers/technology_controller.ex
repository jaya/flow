defmodule FlowWeb.TechnologyController do
  use FlowWeb, :controller

  alias Flow.Jobs
  alias Flow.Jobs.Technology

  plug FlowWeb.Plugs.RequireAuth
  plug FlowWeb.Plugs.RequireAdmin when action in [:index, :new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    technologies = Jobs.list_technologies()
    render(conn, "index.html", technologies: technologies)
  end

  def new(conn, _params) do
    changeset = Jobs.change_technology(%Technology{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"technology" => technology_params}) do
    case Jobs.create_technology(technology_params) do
      {:ok, technology} ->
        conn
        |> put_flash(:info, "Technology created successfully.")
        |> redirect(to: Routes.technology_path(conn, :show, technology))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    technology = Jobs.get_technology!(id)
    render(conn, "show.html", technology: technology)
  end

  def edit(conn, %{"id" => id}) do
    technology = Jobs.get_technology!(id)
    changeset = Jobs.change_technology(technology)
    render(conn, "edit.html", technology: technology, changeset: changeset)
  end

  def update(conn, %{"id" => id, "technology" => technology_params}) do
    technology = Jobs.get_technology!(id)

    case Jobs.update_technology(technology, technology_params) do
      {:ok, technology} ->
        conn
        |> put_flash(:info, "Technology updated successfully.")
        |> redirect(to: Routes.technology_path(conn, :show, technology))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", technology: technology, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    technology = Jobs.get_technology!(id)
    {:ok, _technology} = Jobs.delete_technology(technology)

    conn
    |> put_flash(:info, "Technology deleted successfully.")
    |> redirect(to: Routes.technology_path(conn, :index))
  end
end

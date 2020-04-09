defmodule FlowWeb.JobController do
  use FlowWeb, :controller

  alias Flow.Jobs
  alias Flow.Jobs.Job

  def index(conn, _params) do
    jobs = Jobs.list_jobs()
    IO.inspect jobs
    render(conn, "index.html", jobs: jobs)
  end

  def new(conn, _params) do
    changeset = Jobs.change_job(%Job{})
    clients = Jobs.list_clients() |> Enum.map(&{&1.name,&1.id})
    render(conn, "new.html", changeset: changeset, clients: clients)
  end

  def create(conn, %{"job" => job_params}) do
    clients = Jobs.list_clients() |> Enum.map(&{&1.name,&1.id})
    case Jobs.create_job(job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: Routes.job_path(conn, :show, job))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, clients: clients)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, "show.html", job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    changeset = Jobs.change_job(job)
    clients = Jobs.list_clients() |> Enum.map(&{&1.name,&1.id})
    render(conn, "edit.html", job: job, changeset: changeset, clients: clients)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Jobs.get_job!(id)
    clients = Jobs.list_clients() |> Enum.map(&{&1.name,&1.id})
    case Jobs.update_job(job, job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: Routes.job_path(conn, :show, job))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset, clients: clients)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    {:ok, _job} = Jobs.delete_job(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: Routes.job_path(conn, :index))
  end
end

defmodule FlowWeb.CandidateController do
  use FlowWeb, :controller

  alias Flow.Jobs
  alias Flow.Jobs.Candidate

  def index(conn, _params) do
    status = Jobs.list_status()
    candidates = Jobs.list_candidates()
    render(conn, "index.html", candidates: candidates, status: status)
  end

  def new(conn, _params) do
    jobs = Jobs.list_jobs() |> Enum.map(&{"[#{&1.client.name}] #{&1.name}", &1.id})
    status = Jobs.list_status() |> Enum.map(&{&1.name, &1.id})

    changeset = Jobs.change_candidate(%Candidate{})
    render(conn, "new.html", changeset: changeset, jobs: jobs, status: status)
  end

  def create(conn, %{"candidate" => candidate_params}) do
    jobs = Jobs.list_jobs() |> Enum.map(&{"[#{&1.client.name}] #{&1.name}", &1.id})
    status = Jobs.list_status() |> Enum.map(&{&1.name, &1.id})

    case Jobs.create_candidate(candidate_params) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate created successfully.")
        |> redirect(to: Routes.candidate_path(conn, :show, candidate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, jobs: jobs, status: status)
    end
  end

  def show(conn, %{"id" => id}) do
    candidate = Jobs.get_candidate!(id)
    render(conn, "show.html", candidate: candidate)
  end

  def edit(conn, %{"id" => id}) do
    candidate = Jobs.get_candidate!(id)
    changeset = Jobs.change_candidate(candidate)

    jobs = Jobs.list_jobs() |> Enum.map(&{&1.name, &1.id})
    status = Jobs.list_status() |> Enum.map(&{&1.name, &1.id})

    render(conn, "edit.html", candidate: candidate, changeset: changeset, jobs: jobs, status: status)
  end

  def update(conn, %{"id" => id, "candidate" => candidate_params}) do
    candidate = Jobs.get_candidate!(id)

    jobs = Jobs.list_jobs() |> Enum.map(&{&1.name, &1.id})
    status = Jobs.list_status() |> Enum.map(&{&1.name, &1.id})

    case Jobs.update_candidate(candidate, candidate_params) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate updated successfully.")
        |> redirect(to: Routes.candidate_path(conn, :show, candidate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", candidate: candidate, changeset: changeset, jobs: jobs, status: status)
    end
  end

  def delete(conn, %{"id" => id}) do
    candidate = Jobs.get_candidate!(id)
    {:ok, _candidate} = Jobs.delete_candidate(candidate)

    conn
    |> put_flash(:info, "Candidate deleted successfully.")
    |> redirect(to: Routes.candidate_path(conn, :index))
  end
end

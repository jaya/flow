defmodule FlowWeb.CandidateController do
  use FlowWeb, :controller

  alias Flow.Jobs
  alias Flow.Jobs.Candidate

  def index(conn, _params) do
    candidates = Jobs.list_candidates()
    render(conn, "index.html", candidates: candidates)
  end

  def new(conn, _params) do
    changeset = Jobs.change_candidate(%Candidate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"candidate" => candidate_params}) do
    case Jobs.create_candidate(candidate_params) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate created successfully.")
        |> redirect(to: Routes.candidate_path(conn, :show, candidate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    candidate = Jobs.get_candidate!(id)
    render(conn, "show.html", candidate: candidate)
  end

  def edit(conn, %{"id" => id}) do
    candidate = Jobs.get_candidate!(id)
    changeset = Jobs.change_candidate(candidate)
    render(conn, "edit.html", candidate: candidate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "candidate" => candidate_params}) do
    candidate = Jobs.get_candidate!(id)

    case Jobs.update_candidate(candidate, candidate_params) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate updated successfully.")
        |> redirect(to: Routes.candidate_path(conn, :show, candidate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", candidate: candidate, changeset: changeset)
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

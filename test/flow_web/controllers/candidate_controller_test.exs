defmodule FlowWeb.CandidateControllerTest do
  use FlowWeb.ConnCase
  alias Flow.{Jobs, Account}

  @create_attrs %{
    email: "some email",
    github: "some github",
    linkedin: "some linkedin",
    name: "some name",
    phone: "some phone"
  }

  @update_attrs %{
    email: "some updated email",
    github: "some updated github",
    linkedin: "some updated linkedin",
    name: "some updated name",
    phone: "some updated phone"
  }

  @invalid_attrs %{email: nil, github: nil, linkedin: nil, name: nil, phone: nil}

  def fixture(:candidate) do
    {:ok, status} =
      Jobs.create_status(%{
        description: "some description",
        enable: true,
        name: "some name",
        order: 42
      })

    {:ok, client} =
      Jobs.create_client(%{
        description: "some description",
        logo: "some logo",
        name: "some name"
      })

    {:ok, job} =
      Jobs.create_job(%{
        description: "some description",
        name: "some name",
        positions: 42,
        client_id: client.id
      })

    {:ok, user} =
      Account.create_user(%{
        admin: true,
        avatar: "some avatar",
        email: "user some email",
        name: "some name",
        token: "some token"
      })

    {:ok, candidate} =
      Jobs.create_candidate(
        @create_attrs
        |> Map.put(:status_id, status.id)
        |> Map.put(:job_id, job.id)
        |> Map.put(:user_id, user.id)
      )

    candidate
  end

  setup %{conn: conn} do
    {:ok, user} =
      Account.create_user(%{
        admin: true,
        avatar: "some avatar",
        email: "some email",
        name: "some name",
        token: "some token"
      })

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: user.id)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all candidates", %{conn: conn} do
      conn = get(conn, Routes.candidate_path(conn, :index))
      assert html_response(conn, 200) =~ "Candidates"
    end
  end

  describe "new candidate" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.candidate_path(conn, :new))
      assert html_response(conn, 200) =~ "New Candidate"
    end
  end

  describe "create candidate" do
    @tag create_candidate: "ok"
    test "redirects to show when data is valid", %{conn: conn} do
      {:ok, status} =
        Jobs.create_status(%{
          description: "some description",
          enable: true,
          name: "some name",
          order: 42
        })

      {:ok, client} =
        Jobs.create_client(%{
          description: "some description",
          logo: "some logo",
          name: "some name"
        })

      {:ok, job} =
        Jobs.create_job(%{
          description: "some description",
          name: "some name",
          positions: 42,
          client_id: client.id
        })

      candidate =
        @create_attrs
        |> Map.put(:status_id, status.id)
        |> Map.put(:job_id, job.id)

      conn = post(conn, Routes.candidate_path(conn, :create), candidate: candidate)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.candidate_path(conn, :show, id)

      conn = get(conn, Routes.candidate_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Candidate"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.candidate_path(conn, :create), candidate: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Candidate"
    end
  end

  describe "edit candidate" do
    setup [:create_candidate]

    test "renders form for editing chosen candidate", %{conn: conn, candidate: candidate} do
      conn = get(conn, Routes.candidate_path(conn, :edit, candidate))
      assert html_response(conn, 200) =~ "Edit Candidate"
    end
  end

  describe "update candidate" do
    setup [:create_candidate]

    test "redirects when data is valid", %{conn: conn, candidate: candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @update_attrs)
      assert redirected_to(conn) == Routes.candidate_path(conn, :show, candidate)

      conn = get(conn, Routes.candidate_path(conn, :show, candidate))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, candidate: candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Candidate"
    end
  end

  describe "delete candidate" do
    setup [:create_candidate]

    test "deletes chosen candidate", %{conn: conn, candidate: candidate} do
      conn = delete(conn, Routes.candidate_path(conn, :delete, candidate))
      assert redirected_to(conn) == Routes.candidate_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.candidate_path(conn, :show, candidate))
      end
    end
  end

  defp create_candidate(_) do
    candidate = fixture(:candidate)
    {:ok, candidate: candidate}
  end
end

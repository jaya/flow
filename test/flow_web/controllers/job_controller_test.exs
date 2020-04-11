defmodule FlowWeb.JobControllerTest do
  use FlowWeb.ConnCase

  alias Flow.{Jobs, Account}

  @create_attrs %{description: "some description", name: "some name", positions: 42}
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    positions: 43
  }
  @invalid_attrs %{description: nil, name: nil, positions: nil}

  def fixture(:job) do
    {:ok, client} =
      Jobs.create_client(%{
        description: "some description",
        logo: "some logo",
        name: "some name"
      })

    {:ok, job} = Jobs.create_job(@create_attrs |> Map.put(:client_id, client.id))

    job
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
    test "lists all jobs", %{conn: conn} do
      conn = get(conn, Routes.job_path(conn, :index))
      assert html_response(conn, 200) =~ "Jobs"
    end
  end

  describe "new job" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.job_path(conn, :new))
      assert html_response(conn, 200) =~ "New Job"
    end
  end

  describe "create job" do
    test "redirects to show when data is valid", %{conn: conn} do
      {:ok, client} =
        Jobs.create_client(%{
          description: "some description",
          logo: "some logo",
          name: "some name"
        })

      conn =
        post(conn, Routes.job_path(conn, :create),
          job: @create_attrs |> Map.put(:client_id, client.id)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.job_path(conn, :show, id)

      conn = get(conn, Routes.job_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Job"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.job_path(conn, :create), job: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Job"
    end
  end

  describe "edit job" do
    setup [:create_job]

    test "renders form for editing chosen job", %{conn: conn, job: job} do
      conn = get(conn, Routes.job_path(conn, :edit, job))
      assert html_response(conn, 200) =~ "Edit Job"
    end
  end

  describe "update job" do
    setup [:create_job]

    test "redirects when data is valid", %{conn: conn, job: job} do
      conn = put(conn, Routes.job_path(conn, :update, job), job: @update_attrs)
      assert redirected_to(conn) == Routes.job_path(conn, :show, job)

      conn = get(conn, Routes.job_path(conn, :show, job))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, job: job} do
      conn = put(conn, Routes.job_path(conn, :update, job), job: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Job"
    end
  end

  describe "delete job" do
    setup [:create_job]

    test "deletes chosen job", %{conn: conn, job: job} do
      conn = delete(conn, Routes.job_path(conn, :delete, job))
      assert redirected_to(conn) == Routes.job_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.job_path(conn, :show, job))
      end
    end
  end

  defp create_job(_) do
    job = fixture(:job)
    {:ok, job: job}
  end
end

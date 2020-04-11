defmodule FlowWeb.StatusControllerTest do
  use FlowWeb.ConnCase

  alias Flow.{Jobs, Account}

  @create_attrs %{description: "some description", enable: true, name: "some name", order: 42}
  @update_attrs %{description: "some updated description", enable: false, name: "some updated name", order: 43}
  @invalid_attrs %{description: nil, enable: nil, name: nil, order: nil}

  def fixture(:status) do
    {:ok, status} = Jobs.create_status(@create_attrs)
    status
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

    conn = conn
    |> Plug.Test.init_test_session(user_id: user.id)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all status", %{conn: conn} do
      conn = get(conn, Routes.status_path(conn, :index))
      assert html_response(conn, 200) =~ "Status"
    end
  end

  describe "new status" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.status_path(conn, :new))
      assert html_response(conn, 200) =~ "New Status"
    end
  end

  describe "create status" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.status_path(conn, :show, id)

      conn = get(conn, Routes.status_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Status"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Status"
    end
  end

  describe "edit status" do
    setup [:create_status]

    test "renders form for editing chosen status", %{conn: conn, status: status} do
      conn = get(conn, Routes.status_path(conn, :edit, status))
      assert html_response(conn, 200) =~ "Edit Status"
    end
  end

  describe "update status" do
    setup [:create_status]

    test "redirects when data is valid", %{conn: conn, status: status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @update_attrs)
      assert redirected_to(conn) == Routes.status_path(conn, :show, status)

      conn = get(conn, Routes.status_path(conn, :show, status))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, status: status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Status"
    end
  end

  describe "delete status" do
    setup [:create_status]

    test "deletes chosen status", %{conn: conn, status: status} do
      conn = delete(conn, Routes.status_path(conn, :delete, status))
      assert redirected_to(conn) == Routes.status_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.status_path(conn, :show, status))
      end
    end
  end

  defp create_status(_) do
    status = fixture(:status)
    {:ok, status: status}
  end
end

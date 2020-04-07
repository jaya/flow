defmodule FlowWeb.TechnologyControllerTest do
  use FlowWeb.ConnCase

  alias Flow.Jobs

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:technology) do
    {:ok, technology} = Jobs.create_technology(@create_attrs)
    technology
  end

  describe "index" do
    test "lists all technologies", %{conn: conn} do
      conn = get(conn, Routes.technology_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Technologies"
    end
  end

  describe "new technology" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.technology_path(conn, :new))
      assert html_response(conn, 200) =~ "New Technology"
    end
  end

  describe "create technology" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.technology_path(conn, :create), technology: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.technology_path(conn, :show, id)

      conn = get(conn, Routes.technology_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Technology"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.technology_path(conn, :create), technology: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Technology"
    end
  end

  describe "edit technology" do
    setup [:create_technology]

    test "renders form for editing chosen technology", %{conn: conn, technology: technology} do
      conn = get(conn, Routes.technology_path(conn, :edit, technology))
      assert html_response(conn, 200) =~ "Edit Technology"
    end
  end

  describe "update technology" do
    setup [:create_technology]

    test "redirects when data is valid", %{conn: conn, technology: technology} do
      conn = put(conn, Routes.technology_path(conn, :update, technology), technology: @update_attrs)
      assert redirected_to(conn) == Routes.technology_path(conn, :show, technology)

      conn = get(conn, Routes.technology_path(conn, :show, technology))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, technology: technology} do
      conn = put(conn, Routes.technology_path(conn, :update, technology), technology: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Technology"
    end
  end

  describe "delete technology" do
    setup [:create_technology]

    test "deletes chosen technology", %{conn: conn, technology: technology} do
      conn = delete(conn, Routes.technology_path(conn, :delete, technology))
      assert redirected_to(conn) == Routes.technology_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.technology_path(conn, :show, technology))
      end
    end
  end

  defp create_technology(_) do
    technology = fixture(:technology)
    {:ok, technology: technology}
  end
end

defmodule FlowWeb.UserController do
  use FlowWeb, :controller

  alias Flow.Account

  plug Ueberauth

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.user_path(conn, :login))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _) do

    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      name: extract_name(auth.info.email),
      avatar: auth.info.image,
      provider: auth.provider
    }

    signin(conn, user_params)
  end

  defp extract_name(email), do: String.replace(email,"@jaya.tech", "")

  defp signin(conn, user_params) do
    case Account.create_or_update(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back! #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.job_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error to connect on Github")
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    {:ok, _user} = Account.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end

defmodule FlowWeb.UserController do
  use FlowWeb, :controller

  alias Flow.Account

  plug Ueberauth
  alias FlowWeb.Router.Helpers

  def login(conn, _params) do
    if conn.assigns[:user] do
      conn
      |> put_flash(:info, "You are logged")
      |> redirect(to: Helpers.candidate_path(conn, :index))
      |> halt()
    else
      render(conn, "login.html")
    end
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

  defp extract_name(email), do: String.replace(email, "@jaya.tech", "")

  defp signin(conn, user_params) do
    case Account.create_or_update(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back! #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.candidate_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error to authenticate with google")
        |> redirect(to: Routes.user_path(conn, :login))
    end
  end

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    changeset = Account.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    case Account.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    {:ok, _user} = Account.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end

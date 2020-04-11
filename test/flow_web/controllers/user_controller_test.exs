defmodule FlowWeb.UserControllerTest do
  use FlowWeb.ConnCase

  alias Flow.Account

  @create_attrs %{
    admin: true,
    avatar: "some avatar",
    email: "some email",
    name: "some name",
    token: "some token"
  }
  @update_attrs %{
    admin: false,
    avatar: "some updated avatar",
    email: "some updated email",
    name: "some updated name",
    token: "some updated token"
  }
  @invalid_attrs %{admin: nil, avatar: nil, email: nil, name: nil, token: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end

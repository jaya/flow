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

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

end

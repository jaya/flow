defmodule Flow.AccountTest do
  use Flow.DataCase

  alias Flow.Account

  describe "users" do
    alias Flow.Account.User

    @valid_attrs %{admin: true, avatar: "some avatar", email: "some email", name: "some name", token: "some token"}
    @update_attrs %{admin: false, avatar: "some updated avatar", email: "some updated email", name: "some updated name", token: "some updated token"}
    @invalid_attrs %{admin: nil, avatar: nil, email: nil, name: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.admin == true
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.admin == false
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "comments" do
    alias Flow.Account.Comment

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Account.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Account.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Account.create_comment(@valid_attrs)
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Account.update_comment(comment, @update_attrs)
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_comment(comment, @invalid_attrs)
      assert comment == Account.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Account.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Account.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Account.change_comment(comment)
    end
  end
end

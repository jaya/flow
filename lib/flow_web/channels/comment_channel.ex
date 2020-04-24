defmodule FlowWeb.Channel.CommentChannel do
  use FlowWeb, :channel

  alias Flow.{Jobs, Account}

  @moduledoc """
  mode used to connect in web socket channel
  """

  def join("comments:" <> candidate_id, _params, socket) do
    candidate = Jobs.get_candidate_with_comments!(candidate_id)
    # require IEx; IEx.pry()
    {:ok, %{comments: candidate.comments}, assign(socket, :candidate, candidate)}
  end

  def handle_in("comment:add", %{"text" => text}, socket) do
    candidate = socket.assigns.candidate
    user_id = socket.assigns.user_id

    case Account.create_comment(%{text: text, user_id: user_id, candidate_id: candidate.id}) do
      {:ok, comment} ->
        comment = Account.get_comment!(comment.id)
        broadcast!(socket, "comments:#{socket.assigns.candidate.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{errors: reason}}, socket}
    end
  end

  def handle_in("comment:delete", %{"id" => id}, socket) do
    comment = Account.get_comment!(id)

    case Account.delete_comment(comment) do
      {:ok, _} ->
        broadcast!(socket, "comments:remove", %{id: id})
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{errors: reason}}, socket}
    end
  end
end

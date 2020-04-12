defmodule FlowWeb.Channel.CommentChannel do
  use FlowWeb, :channel

  alias Flow.{Jobs, Account}

  def join("comments:" <> candidate_id, _params, socket) do
    candidate = Jobs.get_candidate_with_comments!(candidate_id)
    # require IEx; IEx.pry()
    {:ok, %{comments: candidate.comments}, assign(socket, :candidate, candidate)}
  end

  def handle_in(name, %{"text" => text}, socket) do
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
end

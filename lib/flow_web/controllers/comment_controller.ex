defmodule FlowWeb.CommentController do
  use FlowWeb, :controller

  alias Flow.{Account, Jobs}

  def delete(conn, %{"id" => id}) do
    comment = Account.get_comment!(id)
    candidate_id = comment.candidate_id
    {:ok, _technology} = Account.delete_comment(comment)

    candidate = Jobs.get_candidate!(candidate_id)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.candidate_path(conn, :show, candidate))
  end
end

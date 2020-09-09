defmodule DgDemo.Posts do
  alias DgDemo.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    (1..30) |> Enum.map(fn n -> "Result: #{n}" end)
  end
end

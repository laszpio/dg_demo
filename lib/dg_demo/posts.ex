defmodule DgDemo.Posts do
  alias DgDemo.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    {:ok, posts} = Hui.search(solr_url(), "*")
    posts.body["response"]["docs"]
  end

  def solr_url do
    headers = [{"Content-type", "application/json"}]
    %Hui.URL{url: "http://localhost:8983/solr/posts", headers: headers}
  end

  def solr_path do
    Application.get_env(:dg_demo, :solr_url)
  end
end

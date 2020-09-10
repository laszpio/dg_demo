defmodule DgDemo.Posts do
  alias DgDemo.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(), do: []

  def list_posts(query) do
    {:ok, posts} = Hui.search(solr_url(), q: query, search: 1)

    posts.body["response"]["docs"]
    |> Enum.map(fn post ->
      %Post{
        id: post["id"],
        slug: post["slug"],
        title: post["title"],
        authors: post["authors"],
        tags: post["tags"],
        html: post["html"]
      }
    end)
  end

  defp solr_url do
    %Hui.URL{url: solr_path(), headers: solr_headers()}
  end

  defp solr_path do
    Application.get_env(:dg_demo, :solr_url)
  end

  defp solr_headers do
    [{"Content-type", "application/json"}]
  end
end

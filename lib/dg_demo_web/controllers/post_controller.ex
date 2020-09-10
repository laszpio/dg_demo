defmodule DgDemoWeb.PostController do
  use DgDemoWeb, :controller

  alias DgDemo.Posts
  alias DgDemo.Posts.Post

  def index(conn, params) do
    search_term = get_in(params, ["q"])
    posts = Posts.list_posts(search_term)

    render(conn, "index.html", posts: posts)
  end
end

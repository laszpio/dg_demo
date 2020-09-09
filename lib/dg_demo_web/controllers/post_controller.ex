defmodule DgDemoWeb.PostController do
  use DgDemoWeb, :controller

  alias DgDemo.Posts
  alias DgDemo.Posts.Post

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end
end

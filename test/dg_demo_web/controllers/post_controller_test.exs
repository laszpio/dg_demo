defmodule DgDemoWeb.PostControllerTest do
  use DgDemoWeb.ConnCase

  alias DgDemo.Posts

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200)
    end
  end
end

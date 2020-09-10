defmodule DgDemo.Posts.Post do
  use Ecto.Schema

  embedded_schema do
    field :slug
    field :title
    field :tags
    field :authors
    field :html
  end

  def new(post) do
    %DgDemo.Posts.Post{}
  end
end

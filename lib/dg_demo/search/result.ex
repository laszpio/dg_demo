defmodule DgDemo.Search.Result do
  use Ecto.Schema

  embedded_schema do
    field :slug
    field :title
    field :tags
    field :authors
    field :html
  end

  def new(result) do
    %DgDemo.Search.Result{}
  end
end

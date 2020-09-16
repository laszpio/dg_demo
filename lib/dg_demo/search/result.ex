defmodule DgDemo.Search.Result do
  use Ecto.Schema

  embedded_schema do
    field :domain
    field :slug
    field :title
    field :tags
    field :authors
  end

  def new(result) do
    to_struct(DgDemo.Search.Result, result)
  end

  defp to_struct(kind, attrs) do
    struct = struct(kind)

    Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
  end
end

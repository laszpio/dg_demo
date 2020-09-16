defmodule DgDemo.Search.Result do
  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search.Result

  @primary_key false
  embedded_schema do
    field :domain
    field :slug
    field :title
    field :tags
    field :authors
    field :created_at, :utc_datetime
  end

  def new(result) do
    to_struct(Result, result)
  end

  def changeset(changeset, params) do
    %Result{}
    |> cast(params, [:domain, :slug, :title, :created_at])
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

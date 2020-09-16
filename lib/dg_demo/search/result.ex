defmodule DgDemo.Search.Result do
  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search.Result

  @primary_key false
  embedded_schema do
    field :domain
    field :slug
    field :title
    field :tags, {:array, :string}
    field :authors, {:array, :string}
    field :created_at, :utc_datetime
  end

  @allowed_fields [:domain, :slug, :title, :tags, :authors, :created_at]

  def new(result) do
    to_struct(Result, result)
  end

  def changeset(changeset, params) do
    cast(%Result{}, params, @allowed_fields)
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

defmodule DgDemo.Search.Result do
  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search.Result

  @primary_key {:id, :string, autogenerate: false}
  embedded_schema do
    field(:domain)
    field(:slug)
    field(:title)
    field(:tags, {:array, :string})
    field(:authors, {:array, :string})
    field(:published_at, :utc_datetime)
  end

  @allowed_fields [:domain, :slug, :title, :tags, :authors, :published_at]

  def changeset(changeset = %Result{}, params) do
    changeset
    |> cast(params, @allowed_fields)
    |> put_change(:id, params["id"])
  end
end

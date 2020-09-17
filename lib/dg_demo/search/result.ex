defmodule DgDemo.Search.Result do
  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search.Result

  embedded_schema do
    field(:domain)
    field(:slug)
    field(:title)
    field(:tags, {:array, :string})
    field(:authors, {:array, :string})
    field(:created_at, :utc_datetime)
  end

  @allowed_fields [:id, :domain, :slug, :title, :tags, :authors, :created_at]

  def changeset(changeset = %Result{}, params) do
    cast(changeset, params, @allowed_fields)
  end
end

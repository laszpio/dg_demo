defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search
  alias DgDemo.Search.Result
  alias DgDemo.Search.Config

  @primary_key false
  embedded_schema do
    embeds_many(:results, Result)
    field(:count, :integer, default: 0)
    field(:total, :integer, default: 0)
    field(:time, :integer, default: 0)
  end

  @doc """
  Returns the list of results.

  ## Examples

      iex> search()
      [%Result{}, ...]

  """
  def search() do
    %Search{results: [], count: 0, total: total_count(), time: 0}
  end

  def search(term) when is_nil(term) or term == "", do: search()

  def search(term) do
    {:ok, response} = Hui.search(Config.solr_endpoint(), q: search_term(term))

    params = parse(response)

    %Search{}
    |> cast(params, [:count, :total, :time])
    |> cast_embed(:results, params.results)
    |> apply_changes()
  end

  def parse(%{body: %{"response" => body, "responseHeader" => header }}) do
    %{
      results: body["docs"],
      count: body["numFound"],
      time: header["QTime"],
      total: total_count()
    }
  end

  def search_term(term) do
    "#{String.trim(term)}*"
  end

  def total_count() do
    case Hui.search(Config.solr_endpoint(), q: "*", rows: 0) do
      {:ok, result} -> result.body["response"]["numFound"]
    end
  end
end

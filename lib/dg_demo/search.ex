defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search
  alias DgDemo.Search.Result

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
  def search(), do: %Search{results: [], count: 0, total: total_count(), time: 0}

  def search(nil), do: search()

  def search(""), do: search()

  def search(term) do
    {:ok, results} = Hui.search(solr_endpoint(), q: search_term(term))

    params = %{
      results: Enum.map(results.body["response"]["docs"], &Result.new(&1)),
      count: results.body["response"]["numFound"],
      time: results.body["responseHeader"]["QTime"],
      total: total_count()
    }

    %Search{}
    |> cast(params, [:count, :total, :time])
    |> Map.get(:data)
    |> Map.put(:results, params.results)
  end

  def search_term(term) do
    "#{String.trim(term)}*"
  end

  def total_count() do
    case Hui.search(solr_endpoint(), q: "*", rows: 0) do
      {:ok, result} -> result.body["response"]["numFound"]
      _ -> :error
    end
  end

  def solr_endpoint do
    %Hui.URL{url: solr_path(), headers: solr_headers()}
  end

  def solr_path do
    solr_url() <> "/" <> solr_core()
  end

  def solr_url do
    Application.get_env(:dg_demo, :solr_url)
  end

  def solr_core do
    Application.get_env(:dg_demo, :solr_core)
  end

  def solr_headers do
    [{"Content-type", "application/json"}]
  end
end

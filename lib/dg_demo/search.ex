defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search
  alias DgDemo.Search.Result

  embedded_schema do
    embeds_many :results, Result
    field :count, :integer, default: 0
    field :total, :integer, default: 0
  end

  @doc """
  Returns the list of results.

  ## Examples

      iex> search()
      [%Result{}, ...]

  """
  def search(), do: %{results: [], count: 0, total: 0}

  def search(nil), do: search()

  def search(term) do
    {:ok, results} = Hui.search(solr_url(), q: search_term(term))

    %Search{
      results: Enum.map(results.body["response"]["docs"], &Result.new(&1)),
      count:  results.body["response"]["numFound"],
      total: total_count()
    }
  end

  defp search_term(term) do
    "#{String.trim(term)}"
  end

  defp total_count() do
    {:ok, results} = Hui.search(solr_url(), q: "*", rows: 0)
    results.body["response"]["numFound"]
  end

  defp solr_url do
    %Hui.URL{url: solr_path(), headers: solr_headers()}
  end

  defp solr_path do
    Application.get_env(:dg_demo, :solr_url)
  end

  defp solr_headers do
    [{"Content-type", "application/json"}]
  end
end

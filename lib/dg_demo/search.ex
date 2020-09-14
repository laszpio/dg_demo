defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false

  alias DgDemo.Search.Result

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Result{}, ...]

  """
  def search(), do: %{results: [], count: 0, total: 0}

  def search(nil), do: search()

  def search(term) do
    {:ok, results} = Hui.search(solr_url(), q: search_term(term))

    %{
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

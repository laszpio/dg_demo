defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias DgDemo.Repo

  alias DgDemo.Search.Result

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Result{}, ...]

  """
  def list_results(), do: []

  def list_results(nil), do: []

  def list_results(query) do
    {:ok, results} = Hui.search(solr_url(), q: String.trim(query))
    Enum.map(results.body["response"]["docs"], fn result -> Result.new(result) end)
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

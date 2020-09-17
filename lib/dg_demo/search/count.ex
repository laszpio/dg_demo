defmodule DgDemo.Search.Count do
  alias DgDemo.Search.Config

  def total_count() do
    case Hui.search(Config.solr_endpoint(), q: "*", rows: 0) do
      {:ok, result} -> result.body["response"]["numFound"]
    end
  end
end

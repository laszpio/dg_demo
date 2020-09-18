defmodule DgDemo.Search do
  @moduledoc """
  The Search context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias DgDemo.Search
  alias DgDemo.Search.{Config, Count, Result}

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
    %Search{results: [], count: 0, total: Count.total_count(), time: 0}
  end

  def search(term) when is_nil(term) or term == "", do: search()

  def search(term) do
    case String.trim(term) do
      "" -> search()
      term -> do_search(term)
    end
  end

  def do_search(term) do
    {:ok, response} = Hui.search(Config.endpoint(), q: search_term(term))

    params = parse(response)

    %Search{}
    |> cast(params, [:count, :total, :time])
    |> cast_embed(:results, params.results)
    |> apply_changes()
  end

  def parse(%{body: %{"response" => body, "responseHeader" => header}}) do
    %{
      results: body["docs"],
      count: body["numFound"],
      time: header["QTime"],
      total: Count.total_count()
    }
  end

  def search_term(term) do
    term |> String.trim() |> URI.decode_www_form()
  end
end

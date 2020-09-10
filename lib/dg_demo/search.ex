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
  def list_results do
    Repo.all(Result)
  end
end

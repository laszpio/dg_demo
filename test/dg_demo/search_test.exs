defmodule DgDemo.SearchTest do
  use ExUnit.Case
  import Mock

  alias DgDemo.Search

  describe "search" do
    @empty %Search{count: 0, total: 42, results: []}

    test "search/0 returns empty search result" do
      response = %{
        body: %{
          "response" => %{"numFound" => 42}
        }
      }

      with_mock Hui, [search: fn _, q: "*", rows: 0 -> {:ok, response} end] do
        assert Search.search() == @empty
      end
    end

    test "search/1 with empty query returns empty search result" do
      response = %{
        body: %{
          "response" => %{"numFound" => 42, "docs" => []},
          "responseHeader" => %{"QTime" => 0}
        }
      }

      with_mock Hui, [search: fn _, _ -> {:ok, response} end] do
        assert Search.search(nil) == @empty
        assert Search.search("") == @empty
      end
    end
  end
end

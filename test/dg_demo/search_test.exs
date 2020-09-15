defmodule DgDemo.SearchTest do
  use ExUnit.Case

  alias DgDemo.Search

  describe "results" do
    alias DgDemo.Search.Result

    @empty %Search{count: 0, total: 0, results: []}

    test "search/0 returns empty search result" do
      assert Search.search() == @empty
    end

    test "search/1 with empty query returns empty search result" do
      assert Search.search(nil) == @empty
      assert Search.search("") == @empty
    end
  end
end

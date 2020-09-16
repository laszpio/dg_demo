defmodule DgDemo.SearchTest do
  use ExUnit.Case
  use MecksUnit.Case

  alias DgDemo.Search

  describe "search" do
    alias DgDemo.Search.Result

    @empty %Search{count: 0, total: 42, results: []}

    @tag :skip
    test "search/0 returns empty search result" do
      assert Search.search() == @empty
    end

    @tag :skip
    test "search/1 with empty query returns empty search result" do
      assert Search.search(nil) == @empty
      assert Search.search("") == @empty
      assert Search.search("  ") == @empty
    end
  end
end

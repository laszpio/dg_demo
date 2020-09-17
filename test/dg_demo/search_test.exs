defmodule DgDemo.SearchTest do
  use ExUnit.Case
  import Mock

  alias DgDemo.Search


  describe "search" do
    @empty %Search{count: 0, total: 42, results: []}

    test "search/0 returns empty search result" do
      with_mock Search.Count, [total_count: fn -> 42 end] do
        assert Search.search() == @empty
      end
    end

    test "search/1 with empty query returns empty search result" do
      with_mock Search.Count, [total_count: fn -> 42 end] do
        assert Search.search(nil) == @empty
        assert Search.search("") == @empty
      end
    end
  end
end

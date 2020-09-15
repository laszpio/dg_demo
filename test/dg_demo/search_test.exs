defmodule DgDemo.SearchTest do
  use ExUnit.Case

  alias DgDemo.Search

  describe "results" do
    alias DgDemo.Search.Result

    test "search/0 returns empty results" do
      assert Search.search() == %Search{count: 0, total: 0, results: []}
    end
  end
end

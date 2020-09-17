defmodule DgDemo.SearchTest do
  use ExUnit.Case
  import Mock

  alias DgDemo.Search
  alias DgDemo.Search.Result

  describe "search" do
    @empty %Search{count: 0, total: 42, results: []}

    test "search/0 returns empty search result" do
      with_mock Search.Count, [total_count: fn -> 42 end] do
        assert Search.search() == @empty
        assert called Search.Count.total_count()
      end
    end

    test "search/1 with empty query returns empty search result" do
      with_mock Search.Count, [total_count: fn -> 42 end] do
        assert Search.search(nil) == @empty
        assert Search.search("") == @empty
        assert Search.search("   ") == @empty
        assert Search.search("\n\n") == @empty
        assert called Search.Count.total_count()
      end
    end

    test "search/1 with single term" do
      response = %{
        body: %{
          "response" => %{
            "numFound" => 3,
            "docs" => [
              %{"id" => "1", "title" => "title 1"},
              %{"id" => "2", "title" => "title 2"},
              %{"id" => "3", "title" => "title 3"}
            ]
          },
          "responseHeader" => %{"QTime" => "2"}
        }
      }

      with_mock Search.Count, [total_count: fn -> 42 end] do
        with_mock Hui, [search: fn(_, [q: "term*"]) -> {:ok, response} end] do
          assert Search.search("term") == %Search{
            total: 42,
            count: 3,
            time: 2,
            results: [
              %Result{id: "1", title: "title 1"},
              %Result{id: "2", title: "title 2"},
              %Result{id: "3", title: "title 3"},
            ]
          }

          assert called Search.Count.total_count()
        end
      end
    end
  end
end

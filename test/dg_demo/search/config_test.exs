defmodule DgDemo.Search.ConfigTest do
  use ExUnit.Case

  alias DgDemo.Search.Config

  test "endpoint/0 returns client endpoint" do
    assert Config.endpoint() == %Hui.URL{
      url: "http://localhost:8983/solr/test_items",
      handler: "select",
      headers: [{"Content-type", "application/json"}]
    }
  end

  test "url/0" do
    assert Config.url() == "http://localhost:8983/solr"
  end

  test "core/0" do
    assert Config.core() == "test_items"
  end
end

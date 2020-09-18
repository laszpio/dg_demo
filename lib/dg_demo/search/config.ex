defmodule DgDemo.Search.Config do
  def endpoint do
    %Hui.URL{url: path(), headers: headers()}
  end

  def path do
    url() <> "/" <> core()
  end

  def url do
    Application.get_env(:dg_demo, :solr_url)
  end

  def core do
    Application.get_env(:dg_demo, :solr_core)
  end

  def headers do
    [{"Content-type", "application/json"}]
  end
end

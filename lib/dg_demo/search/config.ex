defmodule DgDemo.Search.Config do
  def solr_endpoint do
    %Hui.URL{url: solr_path(), headers: solr_headers()}
  end

  def solr_path do
    solr_url() <> "/" <> solr_core()
  end

  def solr_url do
    Application.get_env(:dg_demo, :solr_url)
  end

  def solr_core do
    Application.get_env(:dg_demo, :solr_core)
  end

  def solr_headers do
    [{"Content-type", "application/json"}]
  end
end

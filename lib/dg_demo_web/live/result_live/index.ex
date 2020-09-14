defmodule DgDemoWeb.ResultLive.Index do
  use DgDemoWeb, :live_view

  alias DgDemo.Search
  alias DgDemo.Search.Result

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", search: Search.search())}
  end

  #def handle_params(params, _url, socket) do
  #  {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  #end

  #defp apply_action(socket, :index, %{"q" => q}) do
  #  socket
  #  |> assign(:page_title, "Listing Results")
  #  |> assign(:query, q)
  #  |> assign(:search, Search.search(q))
  #end

  def handle_event("search", %{"q" => q}, socket) do
    {:noreply, assign(socket, query: q, search: Search.search(q))}
  end
end

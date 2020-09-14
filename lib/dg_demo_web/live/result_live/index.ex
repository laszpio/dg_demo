defmodule DgDemoWeb.ResultLive.Index do
  use DgDemoWeb, :live_view

  alias DgDemo.Search
  alias DgDemo.Search.Result

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :search, Search.list_results())}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Results")
    |> assign(:result, nil)
  end

  def handle_event("search", %{"search_field" => %{"q" => q}}, socket) do
    {:noreply, assign(socket, :search, Search.list_results(q))}
  end
end

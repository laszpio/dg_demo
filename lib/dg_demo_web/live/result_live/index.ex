defmodule DgDemoWeb.ResultLive.Index do
  use DgDemoWeb, :live_view

  alias DgDemo.Search

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", search: Search.search())}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"q" => q}) do
    socket
    |> assign(:page_title, "Listing Results")
    |> assign(:query, q)
    |> assign(:search, Search.search(q))
  end

  defp apply_action(socket, :index, _params), do: socket

  def handle_event("search", %{"q" => ""}, socket) do
    socket =
      socket
      |> assign(:query, "")
      |> assign(:search, Search.search())
      |> push_patch(to: Routes.result_index_path(socket, :index))

    {:noreply, socket}
  end

  def handle_event("search", %{"q" => q}, socket) do
    socket =
      socket
      |> assign(:query, q)
      |> assign(:search, Search.search(q))
      |> push_patch(to: Routes.result_index_path(socket, :index, q: q))

    {:noreply, socket}
  end
end

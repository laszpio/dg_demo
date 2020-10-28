defmodule DgDemoWeb.ResultLive.Index do
  use DgDemoWeb, :live_view

  require Logger

  alias DgDemo.Search

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", search: Search.search(), pagination: false)}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"q" => q}) do
    socket
    |> assign(:page_title, "Results")
    |> assign(:pagination, false)
    |> assign(:query, q)
    |> assign(:search, Search.search(q))
  end

  defp apply_action(socket, :index, _params), do: socket

  def handle_event("search", %{"q" => ""}, socket) do
    socket =
      socket
      |> assign(:query, "")
      |> assign(:page_title, "Searching")
      |> assign(:search, Search.search())
      |> assign(:pagination, false)
      |> push_patch(to: Routes.result_index_path(socket, :index))

    {:noreply, socket}
  end

  def handle_event("search", %{"q" => q}, socket) do
    socket =
      socket
      |> assign(:page_title, "Searching")
      |> assign(:query, q)
      |> assign(:search, Search.search(q))
      |> assign(:pagination, false)
      |> push_patch(to: Routes.result_index_path(socket, :index, q: q))

    {:noreply, socket}
  end

  def handle_event("show", %{"q" => q}, socket) do
    socket = assign(socket, :pagination, true)

    {:noreply, socket}
  end
end

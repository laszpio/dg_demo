defmodule DgDemoWeb.ResultLive.Index do
  use DgDemoWeb, :live_view

  alias DgDemo.Search
  alias DgDemo.Search.Result

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :results, list_results())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Results")
    |> assign(:result, nil)
  end

  defp list_results do
    Search.list_results()
  end
end

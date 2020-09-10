defmodule DgDemoWeb.ResultLive.FormComponent do
  use DgDemoWeb, :live_component

  alias DgDemo.Search

  @impl true
  def handle_event("validate", %{"result" => result_params}, socket) do
    changeset =
      socket.assigns.result
      |> Search.change_result(result_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end

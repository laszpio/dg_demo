defmodule DgDemoWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `DgDemoWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, DgDemoWeb.ResultLive.FormComponent,
        id: @result.id || :new,
        action: @live_action,
        result: @result,
        return_to: Routes.result_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, DgDemoWeb.ModalComponent, modal_opts)
  end

  def result_url(result) when is_map(result) do
    result.domain <> "/" <> result.slug
  end

  def result_url(_), do: nil

  def commaseperated(list) when is_list(list) do
    case Enum.reverse(list) do
      [first] -> first
      [first | rest] -> Enum.join(rest, ", ") <> " and " <> first
    end
  end

  def commaseperated(_), do: nil

  def duration(time), do: duration(time, "ms")

  def duration(0, unit), do: "<1" <> unit

  def duration(time, unit), do: "#{time} #{unit}"
end

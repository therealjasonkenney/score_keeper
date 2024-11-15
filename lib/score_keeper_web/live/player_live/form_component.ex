defmodule ScoreKeeperWeb.PlayerLive.FormComponent do
  use ScoreKeeperWeb, :live_component

  alias ScoreKeeper.Players

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage player records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="player-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Player</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{player: player} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Players.change_player(player))
     end)}
  end

  @impl true
  def handle_event("validate", %{"player" => player_params}, socket) do
    changeset = Players.change_player(socket.assigns.player, player_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"player" => player_params}, socket) do
    save_player(socket, socket.assigns.action, player_params)
  end

  defp save_player(socket, :edit, player_params) do
    case Players.update_player(socket.assigns.player, player_params) do
      {:ok, player} ->
        notify_parent({:saved, player})

        {:noreply,
         socket
         |> put_flash(:info, "Player updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_player(socket, :new, player_params) do
    case Players.create_player(player_params) do
      {:ok, player} ->
        notify_parent({:saved, player})

        {:noreply,
         socket
         |> put_flash(:info, "Player created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

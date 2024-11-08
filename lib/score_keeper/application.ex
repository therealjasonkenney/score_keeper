defmodule ScoreKeeper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScoreKeeperWeb.Telemetry,
      ScoreKeeper.Repo,
      {DNSCluster, query: Application.get_env(:score_keeper, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ScoreKeeper.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ScoreKeeper.Finch},
      # Start a worker by calling: ScoreKeeper.Worker.start_link(arg)
      # {ScoreKeeper.Worker, arg},
      # Start to serve requests, typically the last entry
      ScoreKeeperWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScoreKeeper.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScoreKeeperWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule Rafaelguilherme.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RafaelguilhermeWeb.Telemetry,
      Rafaelguilherme.Repo,
      {DNSCluster, query: Application.get_env(:rafaelguilherme, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Rafaelguilherme.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Rafaelguilherme.Finch},
      # Start a worker by calling: Rafaelguilherme.Worker.start_link(arg)
      # {Rafaelguilherme.Worker, arg},
      # Start to serve requests, typically the last entry
      RafaelguilhermeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rafaelguilherme.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RafaelguilhermeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule Amdryzen9600x.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Amdryzen9600xWeb.Telemetry,
      Amdryzen9600x.Repo,
      {DNSCluster, query: Application.get_env(:amdryzen9600x, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Amdryzen9600x.PubSub},
      # Start a worker by calling: Amdryzen9600x.Worker.start_link(arg)
      # {Amdryzen9600x.Worker, arg},
      # Start to serve requests, typically the last entry
      Amdryzen9600xWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Amdryzen9600x.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Amdryzen9600xWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

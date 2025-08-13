defmodule HolidayApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HolidayAppWeb.Telemetry,
      HolidayApp.Repo,
      {DNSCluster, query: Application.get_env(:holiday_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HolidayApp.PubSub},
      # Start a worker by calling: HolidayApp.Worker.start_link(arg)
      # {HolidayApp.Worker, arg},
      # Start to serve requests, typically the last entry
      HolidayAppWeb.Endpoint,
      {Finch, name: HolidayApp.Finch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HolidayApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HolidayAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

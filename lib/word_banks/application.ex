defmodule WordBanks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      WordBanks.Repo,
      # Start the endpoint when the application starts
      WordBanksWeb.Endpoint
      # Starts a worker by calling: WordBanks.Worker.start_link(arg)
      # {WordBanks.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WordBanks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WordBanksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

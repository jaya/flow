# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :flow,
  ecto_repos: [Flow.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :flow, FlowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xuraruQvjjwtZe2VFiJohxlkZYoapGWBfOkaMkilNXDSVi+5Sjjr9uY31L3Cvk8M",
  render_errors: [view: FlowWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Flow.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "/q8rB3MT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

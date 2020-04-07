use Mix.Config

# Configure your database
config :flow, Flow.Repo,
  username: "sa",
  password: "sa",
  database: "flow_test",
  port: 9000,
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :flow, FlowWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

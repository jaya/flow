use Mix.Config

config :flow, FlowWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  load_from_system_env: true,
  url: [scheme: "https", host: "floating-bayou-04566.herokuapp.com", port: 443],
  check_origin: [
    "https://floating-bayou-04566.herokuapp.com",
    "https://www.floating-bayou-04566.herokuapp.com"
  ],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :flow, Flow.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true,
  url: System.get_env("DATABASE_URL")

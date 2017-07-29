# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :around,
  ecto_repos: [Around.Repo]

# Configures the endpoint
config :around, AroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pnxBEo3bzUBO3deJu7HIXIwze2vVJ06nxy7v2LRlRCRy2gGWn3KNKYaAXGGkjLHv",
  render_errors: [view: AroundWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Around.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures geocoder
config :geocoder, Geocoder.Worker, [
    size: 4,
    max_overflow: 2,
    provider: Geocoder.Providers.OpenStreetMaps
]

config :geocoder, Geocoder.Store, [
    precision: 4
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

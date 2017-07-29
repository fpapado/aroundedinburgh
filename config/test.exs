use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :around, AroundWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :around, Around.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rumbl_test",
  hostname: "localhost",
  extensions: [{Geo.PostGIS.Extension, []}],
  pool: Ecto.Adapters.SQL.Sandbox

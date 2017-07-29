Needed ENV vars:
```bash
PORT = ...
mix phoenix.gen.secret
SECRET_KEY_BASE =...
```

Needed in prod.secret.exs:
```elixir
use Mix.Config

config :around, Around.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "...",
  database: "...",
  password: "...",
  hostname: "...",
  extensions: [{Geo.PostGIS.Extension, []}],
  pool_size: ...
```


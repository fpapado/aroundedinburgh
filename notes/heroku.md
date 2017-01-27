# Useful commands
```bash
$ heroku logs # use --tail if you want to tail them

$ heroku run "POOL_SIZE=2 iex -S mix"

$ heroku run "POOL_SIZE=2 mix ecto.migrate"

$ heroku config:set POOL_SIZE=18
```
Heroku free has 20 connections max; 18 leaves room for tasks.

# XTurn Simple Auth

An authentication system with REST API to add users dynamically to the XTurn server

## Installation

# mix.exs

Add this plugin to the XTurn mix file.

```
{:xturn_simple_auth, git: "https://github.com/xirsys/xturn-simple-auth"}
```

# config/config.exs

Add the following to XTurn `config.exs` file.

```
config :xturn, Xirsys.XTurn.SimpleAuth.Server,
  adapter: Plug.Cowboy,
  plug: Xirsys.XTurn.SimpleAuth.API,
  scheme: :http,
  port: 8880

config :xturn,
  maru_servers: [Xirsys.XTurn.SimpleAuth.Server]
```

Next, under the `pipes` section, replace all occurrances of `Xirsys.XTurn.Actions.Authenticates` with `Xirsys.XTurn.SimpleAuth.Actions.Authenticates`.

## Usage

When running XTurn, you can add users by posting to the `/auth` endpoint on port 8880.  The plugin will generate a username and password for you.

```
{
    "status": "ok",
    "password": "05883c85065d19a9ee5742b91fcc80ba",
    "username": "05883c85065cad4663bbec8be1a99b37"
}
```

Alternatively, pass in `username` and `password` values to supply your own.
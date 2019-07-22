use Mix.Config

config :xturn_simple_auth, Xirsys.XTurn.SimpleAuth.Server,
  adapter: Plug.Cowboy,
  plug: Xirsys.XTurn.SimpleAuth.API,
  scheme: :http,
  port: 8880

config :xturn_simple_auth,
  maru_servers: [Xirsys.XTurn.SimpleAuth.Server]

defmodule Xirsys.XTurn.SimpleAuth do
  use Application

  def start(_type, _args) do
  	children = [
      Xirsys.XTurn.SimpleAuth.Server,
      Xirsys.XTurn.SimpleAuth.Client
  	]
    opts = [strategy: :one_for_one, name: Xirsys.XTurn.SimpleAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

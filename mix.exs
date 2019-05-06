defmodule Xirsys.XTurn.SimpleAuth.MixProject do
  use Mix.Project

  def project do
    [
      app: :xturn_simple_auth,
      version: "0.1.0",
      elixir: "~> 1.6.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Simple authentication module for the XTurn server.",
      source_url: "https://github.com/xirsys/xturn-simple-auth",
      homepage_url: "https://xirsys.github.io/xturn/",
      package: package(),
      docs: [
        extras: ["README.md"],
        main: "readme"
      ]
    ]
  end

  def application do
    [mod: {Xirsys.XTurn.SimpleAuth, []}, applications: []]
  end

  defp deps do
    []
  end

  defp package do
    %{
      maintainers: ["Jahred Love"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/xirsys/xturn-simple-auth"}
    }
  end
end
